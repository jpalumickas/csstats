module CSstats
  module Writer
    class FileWriter
      class Handler
        attr_reader :handle

        def initialize(handle)
          @handle = handle
        end

        def write_int_data(int)
          data = [int].pack('V')
          handle.write(data)
        end

        def write_short_data(int)
          data = [int].pack('v')
          handle.write(data)
        end

        def write_string_data(string)
          data = "#{string}\x00"
          handle.write(data)
        end
      end
    end
  end
end
