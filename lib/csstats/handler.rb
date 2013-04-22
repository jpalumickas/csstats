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

      i = 1
      while (!handle.eof? && (maxplayers == 0 || i <= maxplayers))
        player = read_player(handle)
        if player
          player['rank'] = i
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
      p = Hashie::Mash.new
      l = read_short_data(handle);

      return nil if (l == 0)

      p['nick'] = read_string_data(handle, l)
      l = read_short_data(handle)
      p['uniq'] = read_string_data(handle, l)

      p['teamkill'] = read_int_data(handle)
      p['damage'] = read_int_data(handle)
      p['deaths'] = read_int_data(handle)
      p['kills'] = read_int_data(handle)
      p['shots'] = read_int_data(handle)
      p['hits'] = read_int_data(handle)
      p['headshots'] = read_int_data(handle)

      p['defusions'] = read_int_data(handle)
      p['defused'] = read_int_data(handle)
      p['plants'] = read_int_data(handle)
      p['explosions'] = read_int_data(handle)

      read_int_data(handle) # 0x00000000

      p['head'] = read_int_data(handle)
      p['chest'] = read_int_data(handle)
      p['stomach'] = read_int_data(handle)
      p['leftarm'] = read_int_data(handle)
      p['rightarm'] = read_int_data(handle)
      p['leftleg'] = read_int_data(handle)
      p['rightleg'] = read_int_data(handle)

      read_int_data(handle) # 0x00000000

      return p
    end

    # Get the 32bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the integer.
    def read_int_data(handle)
      d = handle.read(4)
      raise CSstats::Error, "Cannot read int data." unless d
      d = d.unpack("V")
      return d[0]
    end

    # Get the 16bit integer from file.
    #
    # handle - The File which was opened for reading data.
    #
    # Returns the integer.
    def read_short_data(handle)
      d = handle.read(2)
      raise CSstats::Error, "Cannot read short data." unless d
      d = d.unpack("v")
      return d[0]
    end

    # Get the string from file.
    #
    # handle - The File which was opened for reading data.
    # len - length of string to read.
    #
    # Returns the string.
    def read_string_data(handle, len)
      d = handle.read(len)
      raise CSstats::Error, "Cannot read string data." unless d
      d = d.strip
      return d
    end

    # Get the player information of specified id.
    #
    # id - The Integer of player id.
    #
    # Returns the Hash of player information.
    def player(id)
      unless (@players[id].nil?)
        @players[id]
      else
        nil
      end
    end

    # Get total players count.
    #
    # Returns the Integer of player count.
    def players_count
      @players.count - 1
    end
  end
end