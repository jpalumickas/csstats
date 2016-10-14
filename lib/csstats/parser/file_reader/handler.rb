module CSstats
  module Parser
    class FileReader
      class Handler
        attr_reader :handle

        def initialize(handle)
          @handle = handle
        end

        # Internal: Get the 32bit integer from file.
        #
        # Returns the Integer.
        def read_int_data
          data = handle.read(4)
          raise CSstats::Error, 'Cannot read int data.' unless data

          data.unpack('V').first
        end

        # Internal: Get the 16bit integer from file.
        #
        # Returns the Integer.
        def read_short_data
          data = handle.read(2)
          raise CSstats::Error, 'Cannot read short data.' unless data

          data.unpack('v').first
        end

        # Internal: Get the String from file.
        #
        # length - The Integer length of string to read.
        #
        # Returns the String.
        def read_string_data(length)
          data = handle.read(length)
          raise CSstats::Error, 'Cannot read string data.' unless data

          data.strip
        end
      end
    end
  end
end
