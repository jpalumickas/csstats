#encoding: UTF-8
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

      @fileversion = readShortData(handle);

      i = 1
      while (!handle.eof? && (maxplayers == 0 || i <= maxplayers))
        player = readPlayer(handle)
        if player
          player['rank'] = i
          players[i] = player
        end
        i = i + 1
      end
    end

    def readPlayer(handle)
      p = {}
      l = readShortData(handle);

      return nil if (l == 0)

      p['nick'] = readStringData(handle, l)
      l = readShortData(handle)
      p['uniq'] = readStringData(handle, l)

      p['teamkill'] = readIntData(handle)
      p['damage'] = readIntData(handle)
      p['deaths'] = readIntData(handle)
      p['kills'] = readIntData(handle)
      p['shots'] = readIntData(handle)
      p['hits'] = readIntData(handle)
      p['headshots'] = readIntData(handle)

      p['defusions'] = readIntData(handle)
      p['defused'] = readIntData(handle)
      p['plants'] = readIntData(handle)
      p['explosions'] = readIntData(handle)

      readIntData(handle) # 0x00000000

      p['head'] = readIntData(handle)
      p['chest'] = readIntData(handle)
      p['stomach'] = readIntData(handle)
      p['leftarm'] = readIntData(handle)
      p['rightarm'] = readIntData(handle)
      p['leftleg'] = readIntData(handle)
      p['rightleg'] = readIntData(handle)

      readIntData(handle) # 0x00000000

      return p
    end

    def readIntData(handle)
      #f = File.new(handle)
      d  = handle.read(4)
      d = d.unpack("V")
      return d[0]
    end

    def readShortData(handle)
      #f = File.new(handle)
      d  = handle.read(2)
      #if ($d === false)
      #  throw new CSstatsException("Can not read data.");
      d = d.unpack("v")
      return d[0]
    end

    def readStringData(handle, len)
      d  = handle.read(len)
      #if ($d === false)
      #  throw new CSstatsException("Can not read data.");
      d = d.strip
      return d
    end

    def getPlayer(id)
      if (@players[id].present?)
        @players[id]
      else
        nil
      end
    end

    def countPlayers
      @players.count - 1
    end
  end
end