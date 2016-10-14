require 'csstats/error'
require 'csstats/parser'
require 'csstats/writer'
require 'csstats/handler'

module CSstats
  # Alias for CSstats::Handler.new
  #
  # Returns CSstats::Handler
  def self.new(options = {})
    CSstats::Handler.new(options)
  end
end
