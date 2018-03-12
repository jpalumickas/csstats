module CSstats
  class Players
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def all
      players
    end

    def find(id)
      players[id - 1]
    end

    def find_by(attributes = {})
      players.find do |player|
        attributes.all? do |column, value|
          player.send(column) == value
        end
      end
    end

    def where(attributes = {})
      players.select do |player|
        attributes.all? do |column, value|
          player.send(column) == value
        end
      end
    end

    # def save
    #   CSstats::Parser.write_players(client, players)
    # end

    def method_missing(method_name, *args, &block)
      return super unless respond_to?(method_name)
      players.send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      players.respond_to?(method_name, include_private)
    end

    private

    def players
      @players ||= CSstats::Parser.get_players(client)
    end
  end
end
