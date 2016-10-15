module CSstats
  module Writer
    class Player
      attr_reader :handler, :player

      def initialize(handler, player)
        @handler = handler
        @player = player
      end

      def write
        CSstats::COLUMNS.each do |column|
          if column.empty?
            handler.write_int_data(0)
            next
          end

          value = player.send(column[:name])
          send("write_#{column[:type]}", value)
        end
      end

      private

      def write_string(value)
        handler.write_short_data(value.length + 1)
        handler.write_string_data(value)
      end

      def write_integer(value)
        handler.write_int_data(value)
      end
    end
  end
end
