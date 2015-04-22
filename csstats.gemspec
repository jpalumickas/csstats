# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csstats/version'

Gem::Specification.new do |gem|
  gem.name = 'csstats'
  gem.version = CSstats::VERSION
  gem.author = 'Justas Palumickas'
  gem.email = 'jpalumickas@gmail.com'
  gem.homepage = 'https://github.com/jpalumickas/csstats/'
  gem.summary = gem.description
  gem.description = 'Gem which handle csstats.dat file generated by CSX' \
                    ' module in AMX Mod X (http://www.amxmodx.org/)'

  gem.license = 'MIT'
  gem.required_ruby_version = '>= 1.9.2'

  gem.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(/^(test|spec|features)\//)
  gem.require_paths = ['lib']

  gem.add_dependency 'hashie', '~> 3.3'
  gem.add_development_dependency 'bundler', '~> 1.5'
end
