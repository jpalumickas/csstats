module CSstats
  module Writer
    class Players
      attr_reader :players

      def initialize(players)
        @players = players
      end

      def write(file_path)
        file = File.new(file_path, 'w')
        handler = CSstats::Writer::FileWriter::Handler.new(file)

        handler.write_short_data(11) # File version

        players.each do |player|
          CSstats::Writer::Player.new(player).write(handler)
        end

        file.close
      end
    end
  end
end
