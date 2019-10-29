# frozen_string_literal: true

module CSstats
  module Parser
    module Writer
      class Players
        attr_reader :file_path

        def initialize(file_path)
          @file_path = file_path
        end

        def write(players)
          file = File.new(file_path, 'w')

          streamer(file).write_short_data(11) # File version

          players.each do |player|
            CSstats::Parser::Writer::Player.new(streamer(file), player).write
          end

          file.close
        end

        def streamer(file)
          CSstats::Parser::Writer::FileStreamer.new(file)
        end
      end
    end
  end
end
