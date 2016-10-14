module CSstats
  class Handler
    attr_reader :file_path, :max_players

    # Public: Initialize file.
    #
    # options - The Hash options:
    #   :path       - The String of csstats.dat file path (required).
    #   :maxplayers - The Integer of how many players to return (optional).
    #
    # Returns nothing.
    def initialize(options = {})
      @file_path = options[:path]
      @max_players = options[:maxplayers] || 0

      raise CSstats::FileNotExist unless File.exist?(file_path.to_s)
    end

    # Public: Get the player information of specified id.
    #
    # id - The Integer of player id.
    #
    # Returns the Mash of player information.
    def player(id)
      players[id - 1]
    end

    # Public: Get total players count.
    #
    # Returns the Integer of player count.
    def players_count
      players.count
    end

    # Public: Get player by specified name.
    #
    # name - The String of player name.
    #
    # Returns the Mash of player information.
    def search_by_name(name)
      players.find { |player| player.nick == name }
    end

    def players
      @players ||= CSstats::Parser::Players.new(
        file_path, max_players: max_players
      ).parse
    end
  end
end
