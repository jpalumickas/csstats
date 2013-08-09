require 'hashie/mash'

module CSstats
  class Handler
    attr_accessor :path, :players, :fileversion, :position

    # Public: Initialize file.
    #
    # Options:
    #   path       - The String of csstats.dat file path.
    #   maxplayers - The Integer of how many players to return.
    #
    # Returns nothing.
    def initialize(options={})
      @path = options[:path]
      @players = []
      @fileversion = 0x00
      @position = 1
      maxplayers = options[:maxplayers] || 0

      return if @path.nil?

      handle = File.new(@path, "r")

      @fileversion = read_short_data(handle);

      i = 0
      while (!handle.eof? && (maxplayers == 0 || i < maxplayers))
        player = read_player(handle)
        if player
          player['rank'] = i + 1
          players[i] = player
        end
        i = i + 1
      end
    end

    # Internal: Read player information from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns The Mash of player information.
    def read_player(handle)
      length = read_short_data(handle);

      return nil if (length == 0)

      mash = Hashie::Mash.new

      mash.nick = read_string_data(handle, length)
      length = read_short_data(handle)
      mash.uniq = read_string_data(handle, length)

      mash.teamkill = read_int_data(handle)
      mash.damage = read_int_data(handle)
      mash.deaths = read_int_data(handle)
      mash.kills = read_int_data(handle)
      mash.shots = read_int_data(handle)
      mash.hits = read_int_data(handle)
      mash.headshots = read_int_data(handle)

      mash.defusions = read_int_data(handle)
      mash.defused = read_int_data(handle)
      mash.plants = read_int_data(handle)
      mash.explosions = read_int_data(handle)

      read_int_data(handle) # 0x00000000

      mash.head = read_int_data(handle)
      mash.chest = read_int_data(handle)
      mash.stomach = read_int_data(handle)
      mash.leftarm = read_int_data(handle)
      mash.rightarm = read_int_data(handle)
      mash.leftleg = read_int_data(handle)
      mash.rightleg = read_int_data(handle)

      mash.acc = mash.hits / mash.shots * 100
      mash.eff = mash.kills / (mash.kills + mash.deaths) * 100

      read_int_data(handle) # 0x00000000

      return mash
    end

    # Internal: Get the 32bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_int_data(handle)
      data = handle.read(4)
      raise CSstats::Error, "Cannot read int data." unless data
      return data.unpack("V").first
    end

    # Internal: Get the 16bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the Integer.
    def read_short_data(handle)
      data = handle.read(2)
      raise CSstats::Error, "Cannot read short data." unless data
      return data.unpack("v").first
    end

    # Internal: Get the String from file.
    #
    # handle - The File which was opened for reading data.
    # len    - The Integer length of string to read.
    #
    # Returns the String.
    def read_string_data(handle, length)
      data = handle.read(length)
      raise CSstats::Error, "Cannot read string data." unless data
      data = data.strip
      return data
    end

    # Internal: Get the player information of specified id.
    #
    # id - The Integer of player id.
    #
    # Returns the Mash of player information.
    def player(id)
      unless (@players[id-1].nil?)
        @players[id-1]
      end
    end

    # Get total players count.
    #
    # Returns the Integer of player count.
    def players_count
      @players.count
    end

    # Get player by specified name.
    #
    # name - The String of player name.
    #
    # Returns the Mash of player information.
    def search_by_name(name)
      @players.each do |player|
        return player if (name == player.nick)
      end
    end
  end
end
