# frozen_string_literal: true

require 'csstats/columns'
require 'csstats/error'
require 'csstats/player'
require 'csstats/parser'
require 'csstats/client'
require 'csstats/players'

module CSstats
  # Alias for CSstats::Handler.new
  #
  # Returns CSstats::Handler
  def self.new(options = {})
    CSstats::Client.new(options)
  end
end
