require 'simplecov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start

require 'csstats'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def csstats_file
  fixture_file('csstats.dat')
end

def fixture_file(filename)
  fixtures = File.expand_path('fixtures', __dir__)
  File.join(fixtures, filename)
end

def tmp_file(filename)
  tmps = File.expand_path('tmp', __dir__)
  File.join(tmps, filename)
end
