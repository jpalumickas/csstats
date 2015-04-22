require 'hashie/mash'

module CSstats
  class Handler
    attr_reader :path, :players, :maxplayers

    # Public: Initialize file.
    #
    # options - The Hash options:
    #   :path       - The String of csstats.dat file path (required).
    #   :maxplayers - The Integer of how many players to return (optional).
    #
    # Returns nothing.
    def initialize(options = {})
      @path = options[:path]
      @maxplayers = options[:maxplayers] || 0

      @players = []
      fail CSstats::FileNotExist unless File.exist?(path.to_s)

      @file = File.new(path, 'r')
      _file_version = read_short_data(@file)

      read_players!
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

    private

    def read_players!
      i = 0
      while !@file.eof? && (maxplayers == 0 || i < maxplayers)
        player = read_player(@file)

        if player
          player['rank'] = i + 1
          players[i] = player
        end

        i += 1
      end
    end

    # Internal: Count player efficiency.
    #
    # kills  - The Integer of player kills in game.
    # deaths - The Integer of player deaths in game.
    #
    # Returns The Float of player efficiency.
    def count_efficiency(kills, deaths)
      (kills.to_f / (kills.to_f + deaths.to_f) * 100).round(2)
    end

    # Internal: Count player accuracy.
    #
    # hits  - The Integer of player hits in game.
    # shots - The Integer of player shots in game.
    #
    # Returns The Float of player accuracy.
    def count_accuracy(hits, shots)
      (hits.to_f / shots.to_f * 100).round(2)
    end

    # Internal: Read player information from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns The Mash of player information.
    def read_player(handle)
      length = read_short_data(handle)
      return if length == 0

      player_data = Hashie::Mash.new

      player_data.nick = read_string_data(handle, length)

      add_player_uniq(player_data, handle)
      add_player_general_data(player_data, handle)
      add_player_calculations(player_data)

      player_data
    end

    def add_player_uniq(player_data, handle)
      length = read_short_data(handle)
      player_data.uniq = read_string_data(handle, length)
    end

    def add_player_general_data(player_data, handle)
      data_types = %w(teamkill damage deaths kills shots hits headshots
                      defusions defused plants explosions - head chest stomach
                      leftarm rightarm leftleg rightleg -)

      data_types.each { |type| player_data[type] = read_int_data(handle) }

      # Remove all 0x00000000
      player_data.tap { |x| x.delete('-') }
    end

    def add_player_calculations(player_data)
      player_data.acc = count_accuracy(player_data.hits, player_data.shots)
      player_data.eff = count_efficiency(player_data.kills, player_data.deaths)
    end

    # Internal: Get the 32bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_int_data(handle)
      data = handle.read(4)
      fail CSstats::Error, 'Cannot read int data.' unless data

      data.unpack('V').first
    end

    # Internal: Get the 16bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_short_data(handle)
      data = handle.read(2)
      fail CSstats::Error, 'Cannot read short data.' unless data

      data.unpack('v').first
    end

    # Internal: Get the String from file.
    #
    # handle - The File which was opened for reading data.
    # len    - The Integer length of string to read.
    #
    # Returns the String.
    def read_string_data(handle, length)
      data = handle.read(length)
      fail CSstats::Error, 'Cannot read string data.' unless data

      data.strip
    end
  end
end
