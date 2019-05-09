# AuxiliaryRails

Collection of classes, configs, scripts, generators for Ruby on Rails helping you get things done, better.

[![Gem](https://img.shields.io/gem/v/auxiliary_rails.svg)](https://rubygems.org/gems/auxiliary_rails)
[![Build Status](https://travis-ci.org/ergoserv/auxiliary_rails.svg?branch=master)](https://travis-ci.org/ergoserv/auxiliary_rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/a317c4893a804ce577ab/maintainability)](https://codeclimate.com/github/ergoserv/auxiliary_rails/maintainability)

## Installation

Add one of these lines to your application's Gemfile:

```ruby
# version released to RubyGems
gem 'auxiliary_rails'
# or latest version from the repository
gem 'auxiliary_rails', git: 'https://github.com/ergoserv/auxiliary_rails'
# or from a specific branch of the repository
gem 'auxiliary_rails', github: 'ergoserv/auxiliary_rails', branch: 'develop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auxiliary_rails

## Usage

### Rails Application Templates

```sh
rails new app_name --skip-action-cable --skip-coffee --skip-test --skip-bundle -m https://raw.githubusercontent.com/ergoserv/auxiliary_rails/develop/templates/rails/template.rb
```

### Generators

```sh
rails generate auxiliary_rails:install_errors
rails generate auxiliary_rails:install_rubocop
rails generate auxiliary_rails:install_rubocop --no-specify-gems
```

### View Helpers

```ruby
current_controller?(*ctrl_names)
current_action?(*action_names)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ergoserv/auxiliary_rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

-------------------------------------------------------------------------------

[![alt text](https://raw.githubusercontent.com/ergoserv/auxiliary_rails/master/assets/ErgoServ_horizontalColor@sign+text+bg.png "ErgoServ - Web and Mobile Development Company")](https://www.ergoserv.com)

This gem was created and is maintained by [ErgoServ](https://www.ergoserv.com).

If you like what you see and would like to hire us or join us, [get in touch](https://www.ergoserv.com)!
