# frozen_string_literal: true

class Lummox::PixelFormat
  def initialize(flag_value)
    @flag_value = flag_value
  end

  def special_format?
    @special_format ||= !@flag_value.nil? && @flag_value.nonzero? && value_from(28, 0x0f) != 1
  end

  def type_group
    @type_group ||= case type
                    when /index/
                      :bitmap
                    when /packed/
                      :packed
                    when /array/
                      :array
                    else
                      :unknown
                    end
  end

  def type
    @type ||= if special_format?
                special_format_type
              else
                enum_value_from(Lummox::SDL::PixelType, 24, 0x0f, prefix: :pixel_type_)
              end
  end

  def order
    @order ||= case type_group
               when :bitmap
                 enum_value_from(Lummox::SDL::BitmapOrder, 20, 0x0f, prefix: :bitmap_order_)
               when :packed
                 enum_value_from(Lummox::SDL::PackedOrder, 20, 0x0f, prefix: :packed_order_)
               when :array
                 enum_value_from(Lummox::SDL::ArrayOrder, 20, 0x0f, prefix: :array_order_)
               else
                 :unknown
               end
  end

  def layout
    @layout ||= if type_group == :packed
                  enum_value_from(Lummox::SDL::PackedLayout, 16, 0x0f, prefix: :packed_layout_)
                else
                  :unknown
                end
  end

  def bits_per_pixel
    @bits_per_pixel = value_from(8, 0xff)
  end

  def bytes_per_pixel
    @bytes_per_pixel = if special_format?
                         special_format_bytes_per_pixel
                       else
                         value_from(0, 0xff)
                       end
  end

  def alpha?
    @alpha ||= case type_group
    when :packed, :array
      order.match?(/a/)
    else
      false
    end
  end

  def inspect
    if special_format?
      "#<#{self.class} type=#{type} Bpp=#{bytes_per_pixel}>"
    elsif layout.nil?
      "#<#{self.class} type=#{type} order=#{order} bpp=#{bits_per_pixel} Bpp=#{bytes_per_pixel}>"
    else
      "#<#{self.class} type=#{type} order=#{order} layout=#{layout} bpp=#{bits_per_pixel} Bpp=#{bytes_per_pixel}>"
    end
  end

  private

  def enum_value_from(enum, offset, mask, prefix: "")
    index = value_from(offset, mask)
    remove_prefix(enum[index], prefix)
  end

  def value_from(offset, mask)
    (@flag_value >> offset) & mask
  end

  def remove_prefix(prefixed_flag, prefix)
    prefixed_flag[prefix.size..].downcase.to_sym
  end

  def special_format_type
    [
      value_from(0, 0xff).chr,
      value_from(8, 0xff).chr,
      value_from(16, 0xff).chr,
      value_from(24, 0xff).chr
    ].join
  end

  def special_format_bytes_per_pixel
    case special_format_type
    when "YUY2", "UYVY", "YVYU"
      2
    else
      1
    end
  end
end
