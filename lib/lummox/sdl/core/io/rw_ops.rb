# frozen_string_literal: true

class Lummox::SDL::Core::IO::RWOps < Lummox::SDL::Core::Struct
  layout :size,   :pointer,
         :seed,   :pointer,
         :read,   :pointer,
         :write,  :pointer,
         :close,  :pointer,
         :type,   Lummox::SDL::Core::IO::RWOpsType,
         :data_1, :pointer,
         :data_2, :pointer
end
