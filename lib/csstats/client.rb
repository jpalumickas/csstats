module CSstats
  class Client
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

    def players
      @players ||= CSstats::Players.new(self)
    end
  end
end
