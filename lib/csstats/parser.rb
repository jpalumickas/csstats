require_relative 'parser/file_reader/handler'
require_relative 'parser/file_reader'
require_relative 'parser/player'
require_relative 'parser/players'

module CSstats
  module Parser
    class << self
      def get_players(client)
        CSstats::Parser::Players.new(
          client.file_path, max_players: client.max_players
        ).parse
      end
    end
  end
end
