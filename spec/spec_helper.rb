require 'simplecov'
require 'coveralls'
require 'codeclimate-test-reporter'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
  CodeClimate::TestReporter::Formatter
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
  fixtures = File.expand_path('../fixtures', __FILE__)
  File.new(fixtures + '/csstats.dat').path
end
