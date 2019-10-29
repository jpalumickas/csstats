# frozen_string_literal: true

module CSstats
  module Parser
    module Writer
      class Player
        attr_reader :streamer, :player

        def initialize(streamer, player)
          @streamer = streamer
          @player = player
        end

        def write
          CSstats::COLUMNS.each do |column|
            next streamer.write_int_data(0) if column.empty?

            value = player.send(column[:name])
            send("write_#{column[:type]}", value)
          end
        end

        private

        def write_string(value)
          streamer.write_short_data(value.length + 1)
          streamer.write_string_data("#{value}\x00")
        end

        def write_integer(value)
          streamer.write_int_data(value)
        end
      end
    end
  end
end
