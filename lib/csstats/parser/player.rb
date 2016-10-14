require 'hashie/mash'

module CSstats
  module Parser
    class Player
      DATA_COLUMNS = %w(
        teamkill damage deaths kills shots hits headshots defusions defused
        plants explosions - head chest stomach leftarm rightarm leftleg
        rightleg -
      ).freeze

      # Internal: Parse player information from file.
      #
      # handle - The File which was opened for reading data.
      #
      # Returns The Mash of player information.
      def parse(handler)
        length = handler.read_short_data
        return if length.zero?

        player_data = Hashie::Mash.new
        player_data.nick = handler.read_string_data(length)

        add_data(player_data, handler)

        player_data
      end

      private

      def add_data(player_data, handler)
        add_uniq(player_data, handler)
        add_general_data(player_data, handler)
        add_calculations(player_data)
      end

      def add_uniq(player_data, handler)
        length = handler.read_short_data
        player_data.uniq = handler.read_string_data(length)
      end

      def add_general_data(player_data, handler)
        DATA_COLUMNS.each { |type| player_data[type] = handler.read_int_data }

        # Remove all 0x00000000
        player_data.tap { |x| x.delete('-') }
      end

      def add_calculations(player_data)
        player_data.acc = count_accuracy(player_data.hits, player_data.shots)
        player_data.eff = count_efficiency(
          player_data.kills, player_data.deaths
        )
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
    end
  end
end
