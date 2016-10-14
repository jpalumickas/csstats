module CSstats
  module Writer
    class Player
      attr_reader :player

      def initialize(player)
        @player = player
      end

      def write(handler)
        write_nick(handler)
        write_uniq(handler)
        write_general_data(handler)
      end

      private

      def write_nick(handler)
        handler.write_short_data(player.nick.length + 1)
        handler.write_string_data(player.nick)
      end

      def write_uniq(handler)
        handler.write_short_data(player.uniq.length + 1)
        handler.write_string_data(player.uniq)
      end

      def write_general_data(handler)
        CSstats::Parser::Player::DATA_COLUMNS.each do |type|
          if type == '-'
            handler.write_int_data(0)
          else
            handler.write_int_data(player[type])
          end
        end
      end
    end
  end
end
