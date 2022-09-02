# frozen_string_literal: true

class Lummox::SDL::IO::RWOps < Lummox::SDL::Struct
  layout :size,   :pointer,
         :seed,   :pointer,
         :read,   :pointer,
         :write,  :pointer,
         :close,  :pointer,
         :type,   Lummox::SDL::IO::RWOpsType,
         :data_1, :pointer,
         :data_2, :pointer
end
