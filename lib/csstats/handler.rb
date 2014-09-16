require 'hashie/mash'

module CSstats
  class Handler
    attr_reader :path, :players

    # Public: Initialize file.
    #
    # options - The Hash options:
    #   :path       - The String of csstats.dat file path (required).
    #   :maxplayers - The Integer of how many players to return (optional).
    #
    # Returns nothing.
    def initialize(options = {})
      @path = options[:path]
      @players = []
      return if path.nil?

      maxplayers = options[:maxplayers] || 0

      file = File.new(path, 'r')
      file_version = read_short_data(file)

      i = 0
      while !file.eof? && (maxplayers == 0 || i < maxplayers)
        player = read_player(file)

        if player
          player['rank'] = i + 1
          players[i] = player
        end

        i += 1
      end
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
      return nil if length == 0

      mash = Hashie::Mash.new

      mash.nick = read_string_data(handle, length)
      length = read_short_data(handle)
      mash.uniq = read_string_data(handle, length)

      read_data = %w(teamkill damage deaths kills shots hits headshots
                     defusions defused plants explosions - head chest stomach
                     leftarm rightarm leftleg rightleg -)

      read_data.each { |data| mash[data] = read_int_data(handle) }

      # Remove all 0x00000000
      mash.tap { |x| x.delete('-') }

      mash.acc = count_accuracy(mash.hits, mash.shots)
      mash.eff = count_efficiency(mash.kills, mash.deaths)

      mash
    end

    # Internal: Get the 32bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_int_data(handle)
      data = handle.read(4)
      raise CSstats::Error, 'Cannot read int data.' unless data

      data.unpack('V').first
    end

    # Internal: Get the 16bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_short_data(handle)
      data = handle.read(2)
      raise CSstats::Error, 'Cannot read short data.' unless data

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
      raise CSstats::Error, 'Cannot read string data.' unless data

      data.strip
    end
  end
end
