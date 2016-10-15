module CSstats
  module Parser
    class Player
      attr_reader :handler

      def initialize(handler)
        @handler = handler
      end

      def parse
        player = CSstats::Player.new

        CSstats::COLUMNS.each do |column|
          if column.empty?
            parse_integer
            next
          end

          data = send("parse_#{column[:type]}")
          return unless data
          player.send("#{column[:name]}=", data)
        end

        player
      end

      private

      def parse_string
        length = handler.read_short_data
        return if length.zero?
        handler.read_string_data(length)
      end

      def parse_integer
        handler.read_int_data
      end
    end
  end
end
