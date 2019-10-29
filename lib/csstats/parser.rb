# frozen_string_literal: true

require_relative 'parser/reader'
require_relative 'parser/writer'

module CSstats
  module Parser
    class << self
      def get_players(client)
        CSstats::Parser::Reader::Players.new(
          client.file_path, max_players: client.max_players
        ).parse
      end

      def write_players(client, players)
        CSstats::Parser::Writer::Players.new(client.file_path).write(players)
      end
    end
  end
end
