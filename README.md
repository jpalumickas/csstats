# CSstats

Gem which handle csstats.dat file generated by CSX module
in AMX Mod X ([http://www.amxmodx.org/][amxx])

[![Gem Version](https://badge.fury.io/rb/csstats.png)][rubygems]
[![Build Status](https://secure.travis-ci.org/jpalumickas/csstats.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/jpalumickas/csstats.png?travis)][gemnasium]
[![Coverage Status](https://coveralls.io/repos/jpalumickas/csstats/badge.png?branch=master)][coveralls]
[![Code Climate](https://codeclimate.com/github/jpalumickas/csstats.png)][codeclimate]

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

You can find player by specified name.

```ruby
stats = CSstats.new(path: 'csstats.dat')
stats.search_by_name('nick')
```

## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0

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