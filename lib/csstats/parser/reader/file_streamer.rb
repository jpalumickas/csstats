# frozen_string_literal: true

module CSstats
  module Parser
    module Reader
      class FileStreamer
        attr_reader :stream

        def initialize(stream)
          @stream = stream
        end

        # Internal: Get the 32bit integer from file.
        #
        # Returns the Integer.
        def read_int_data
          data = stream.read(4)
          raise CSstats::Error, 'Cannot read int data.' unless data

          data.unpack1('V')
        end

        # Internal: Get the 16bit integer from file.
        #
        # Returns the Integer.
        def read_short_data
          data = stream.read(2)
          raise CSstats::Error, 'Cannot read short data.' unless data

          data.unpack1('v')
        end

        # Internal: Get the String from file.
        #
        # length - The Integer length of string to read.
        #
        # Returns the String.
        def read_string_data(length)
          data = stream.read(length)
          raise CSstats::Error, 'Cannot read string data.' unless data

          data.strip
        end
      end
    end
  end
end
