require 'hashie/mash'

module CSstats
  class Handler
    attr_accessor :path, :players, :fileversion, :position

    # Initialize file.
    #
    # Options:
    #   path - The String of csstats.dat file.
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

    # Read player information from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns The Hash (Mash) of player information.
    def read_player(handle)
      hash = Hashie::Mash.new
      length = read_short_data(handle);

      return nil if (length == 0)

      hash.nick = read_string_data(handle, length)
      length = read_short_data(handle)
      hash.uniq = read_string_data(handle, length)

      hash.teamkill = read_int_data(handle)
      hash.damage = read_int_data(handle)
      hash.deaths = read_int_data(handle)
      hash.kills = read_int_data(handle)
      hash.shots = read_int_data(handle)
      hash.hits = read_int_data(handle)
      hash.headshots = read_int_data(handle)

      hash.defusions = read_int_data(handle)
      hash.defused = read_int_data(handle)
      hash.plants = read_int_data(handle)
      hash.explosions = read_int_data(handle)

      read_int_data(handle) # 0x00000000

      hash.head = read_int_data(handle)
      hash.chest = read_int_data(handle)
      hash.stomach = read_int_data(handle)
      hash.leftarm = read_int_data(handle)
      hash.rightarm = read_int_data(handle)
      hash.leftleg = read_int_data(handle)
      hash.rightleg = read_int_data(handle)

      hash.acc = hash['hits'] / hash['shots'] * 100
      hash.eff = hash['kills'] / (hash['kills'] + hash['deaths']) * 100

      read_int_data(handle) # 0x00000000

      return hash
    end

    # Get the 32bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the integer.
    def read_int_data(handle)
      data = handle.read(4)
      raise CSstats::Error, "Cannot read int data." unless data
      return data.unpack("V").first
    end

    # Get the 16bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the integer.
    def read_short_data(handle)
      data = handle.read(2)
      raise CSstats::Error, "Cannot read short data." unless data
      return data.unpack("v").first
    end

    # Get the string from file.
    #
    # handle - The File which was opened for reading data.
    # len - length of string to read.
    #
    # Returns the string.
    def read_string_data(handle, length)
      data = handle.read(length)
      raise CSstats::Error, "Cannot read string data." unless data
      data = data.strip
      return data
    end

    # Get the player information of specified id.
    #
    # id - The Integer of player id.
    #
    # Returns the Hash of player information.
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
    # Returns the Hash of player information.
    def search_by_name(name)
      @players.each do |player|
        return player if (name == player.nick)
      end
    end
  end
end
