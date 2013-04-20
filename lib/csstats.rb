require 'csstats/handler'

module CSstats
  class << self

    # Alias for CSstats::Handler.new
    #
    # Returns CSstats::Handler
    def new(options={})
      CSstats::Handler.new(options)
    end

  end
end