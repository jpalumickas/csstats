require 'hashie/mash'

module CSstats
  class Handler
    attr_accessor :path, :players, :fileversion, :position

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

    def read_int_data(handle)
      #f = File.new(handle)
      d  = handle.read(4)
      d = d.unpack("V")
      return d[0]
    end

    def read_short_data(handle)
      #f = File.new(handle)
      d  = handle.read(2)
      #if ($d === false)
      #  throw new CSstatsException("Can not read data.");
      d = d.unpack("v")
      return d[0]
    end

    def read_string_data(handle, len)
      d  = handle.read(len)
      #if ($d === false)
      #  throw new CSstatsException("Can not read data.");
      d = d.strip
      return d
    end

    def player(id)
      unless (@players[id].nil?)
        @players[id]
      else
        nil
      end
    end

    def players_count
      @players.count - 1
    end
  end
end