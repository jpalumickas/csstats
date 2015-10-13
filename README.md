# CSstats

[![Gem Version](https://img.shields.io/gem/v/csstats.svg?style=flat-square)][rubygems]
[![Build Status](https://img.shields.io/travis/jpalumickas/csstats.svg?style=flat-square)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/jpalumickas/csstats.svg?style=flat-square)][gemnasium]
[![Coverage Status](https://img.shields.io/coveralls/jpalumickas/csstats.svg?branch=master&style=flat-square)][coveralls]
[![Code Climate](https://img.shields.io/codeclimate/github/jpalumickas/csstats.svg?style=flat-square)][codeclimate]

Gem which handle `csstats.dat` file generated by CSX module
in AMX Mod X ([http://www.amxmodx.org/][amxx])

## Installation

Add this line to your application's Gemfile:

    gem 'csstats'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csstats

## Usage

```ruby
require 'csstats'

stats = CSstats.new(path: 'csstats.dat')
stats.player(2).nick
```

You can set maxplayers value if you need to get specified number of players.

```ruby
stats = CSstats.new(path: 'csstats.dat', maxplayers: 15)
stats.players_count
 # => 15
```

You can get player information by specified name.

```ruby
stats = CSstats.new(path: 'csstats.dat')
player_stats = stats.search_by_name('nick')

puts player_stats.kills
```

## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* Ruby 2.1.0
* Ruby 2.2.0

## Copyright
Copyright (c) 2013 Justas Palumickas.
See [LICENSE][] for details.

[rubygems]: https://rubygems.org/gems/csstats
[travis]: http://travis-ci.org/jpalumickas/csstats
[gemnasium]: https://gemnasium.com/jpalumickas/csstats
[coveralls]: https://coveralls.io/r/jpalumickas/csstats
[codeclimate]: https://codeclimate.com/github/jpalumickas/csstats

[amxx]: http://www.amxmodx.org/
[license]: LICENSE.md
