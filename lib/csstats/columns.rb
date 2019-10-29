# frozen_string_literal: true

module CSstats
  COLUMNS = [
    { name: :nick, type: :string },
    { name: :uniq, type: :string },
    { name: :teamkill, type: :integer },
    { name: :damage, type: :integer },
    { name: :deaths, type: :integer },
    { name: :kills, type: :integer },
    { name: :shots, type: :integer },
    { name: :hits, type: :integer },
    { name: :headshots, type: :integer },
    { name: :defusions, type: :integer },
    { name: :defused, type: :integer },
    { name: :plants, type: :integer },
    { name: :explosions, type: :integer },
    {}, # Empty
    { name: :head, type: :integer },
    { name: :chest, type: :integer },
    { name: :stomach, type: :integer },
    { name: :leftarm, type: :integer },
    { name: :rightarm, type: :integer },
    { name: :leftleg, type: :integer },
    { name: :rightleg, type: :integer },
    {} # Empty
  ].freeze

  COLUMN_KEYS = COLUMNS.reject(&:empty?).flat_map { |column| column[:name] }
end
