# ADSB

Automatic Dependent Surveillance Broadcast is a cooperative surveillance
technology in which an aircraft determines its position via satellite navigation
and periodically broadcasts it. This gem decodes automatic dependent
surveillance broadcasts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-adsb', require: 'adsb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-adsb

## Usage

Create a new message:

```ruby
message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
```

Get the address of the sender:

```ruby
address = message.address
```

### Identification

Get the reported identification:

```ruby
identification = message.identification
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/lboekhorst/ruby-adsb.

## License

The gem is available as open source under the terms of the
[MIT](http://opensource.org/licenses/MIT) license.
