module CSstats
  module Parser
    module Reader
      class Player
        attr_reader :stream

        def initialize(stream)
          @stream = stream
        end

        def parse
          player = CSstats::Player.new
          parse_columns(player)
          return unless player.nick
          player
        end

        private

        def parse_columns(player)
          CSstats::COLUMNS.each do |column|
            next parse_integer if column.empty?

            data = send("parse_#{column[:type]}") || break
            player.send("#{column[:name]}=", data)
          end
        end

        def parse_string
          length = stream.read_short_data
          return if length.zero?
          stream.read_string_data(length)
        end

        def parse_integer
          stream.read_int_data
        end
      end
    end
  end
end
