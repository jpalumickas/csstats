# frozen_string_literal: true

require 'simplecov'

formatters = [SimpleCov::Formatter::HTMLFormatter]

if ENV['CODECOV_TOKEN']
  require 'codecov'
  formatters << SimpleCov::Formatter::Codecov
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)
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
