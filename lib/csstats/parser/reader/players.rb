module CSstats
  module Parser
    module Reader
      class Players
        attr_reader :file_path, :max_players

        def initialize(file_path, options = {})
          @file_path = file_path
          @max_players = options[:max_players] || 0
        end

        def parse
          players = []

          file_reader.read do |streamer, index|
            parse_player(streamer, index, players)
          end

          players
        end

        private

        def parse_player(streamer, index, players)
          player_parser = CSstats::Parser::Reader::Player.new(streamer)
          player = player_parser.parse
          return unless player

          player.rank = index + 1
          players[index] = player
        end

        def file_reader
          @file_reader ||= CSstats::Parser::Reader::FileReader.new(
            file_path, limit: max_players
          )
        end
      end
    end
  end
end
