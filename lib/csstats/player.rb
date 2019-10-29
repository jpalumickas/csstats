# frozen_string_literal: true

module CSstats
  class Player
    attr_accessor :rank

    def initialize(attributes = {})
      CSstats::COLUMN_KEYS.each do |column|
        self.class.send(:attr_accessor, column)
      end

      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def efficiency
      kills_and_deaths = kills.to_f + deaths.to_f
      return 0.0 if kills_and_deaths.zero?

      (kills.to_f / kills_and_deaths * 100).round(2)
    end

    def accuracy
      return 0.0 if shots.to_f.zero?

      (hits.to_f / shots.to_f * 100).round(2)
    end

    def as_json
      CSstats::COLUMN_KEYS.each_with_object({}) do |column, object|
        object[column] = send(column)
      end
    end
  end
end
