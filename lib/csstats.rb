require 'csstats/error'
require 'csstats/handler'

module CSstats
  # Alias for CSstats::Handler.new
  #
  # Returns CSstats::Handler
  def self.new(options = {})
    CSstats::Handler.new(options)
  end
end
