require 'csstats/handler'

module CSstats
  class << self

    def new(options={})
      CSstats::Handler.new(options)
    end

  end
end