# frozen_string_literal: true

module CSstats
  module Parser
    module Writer
      class FileStreamer
        attr_reader :stream

        def initialize(stream)
          @stream = stream
        end

        def write_int_data(int)
          data = [int].pack('V')
          stream.write(data)
        end

        def write_short_data(int)
          data = [int].pack('v')
          stream.write(data)
        end

        def write_string_data(string)
          stream.write(string)
        end
      end
    end
  end
end
