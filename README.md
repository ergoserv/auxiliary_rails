# AuxiliaryRails

Collection of classes, configs, scripts, generators for Ruby on Rails helping you get things done, better.

[![Gem](https://img.shields.io/gem/v/auxiliary_rails.svg)](https://rubygems.org/gems/auxiliary_rails)
[![Build Status](https://travis-ci.org/ergoserv/auxiliary_rails.svg?branch=master)](https://travis-ci.org/ergoserv/auxiliary_rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/a317c4893a804ce577ab/maintainability)](https://codeclimate.com/github/ergoserv/auxiliary_rails/maintainability)

## Installation

Add one of these lines to your application's `Gemfile`:

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

Install gem into the system (e.g. using `gem install auxiliary_rails`) then:

```sh
auxiliary_rails new APP_PATH
```

Or use `rails new` command specifying `--template` argument:

```sh
rails new APP_PATH --skip-action-cable --skip-coffee --skip-test --database=postgresql --template=https://raw.githubusercontent.com/ergoserv/auxiliary_rails/develop/templates/rails/elementary.rb
```

### Generators

```sh
# Install everything at once
rails generate auxiliary_rails:install

# Install one by one
rails generate auxiliary_rails:install_commands
rails generate auxiliary_rails:install_errors
rails generate auxiliary_rails:install_rubocop
rails generate auxiliary_rails:install_rubocop --no-specify-gems

# API resource generator
rails generate auxiliary_rails:api_resource

# Command generator
rails generate auxiliary_rails:command
```

### Command Objects

Variation of implementation of [Command pattern](https://en.wikipedia.org/wiki/Command_pattern).

```ruby
# app/commands/application_command.rb
class ApplicationCommand < AuxiliaryRails::AbstractCommand
end

# app/commands/register_user_command.rb
class RegisterUserCommand < ApplicationCommand
  # Define command arguments
  # using `param` or `option` methods provided by dry-initializer
  # https://dry-rb.org/gems/dry-initializer/3.0/
  param :email
  param :password

  # Define the results of the command
  # using `attr_reader` and set it as a regular instance var inside the command
  attr_reader :user

  # Regular Active Model Validations can be used to validate params
  # https://api.rubyonrails.org/classes/ActiveModel/Validations.html
  # Use #valid?, #invalid?, #validate! methods to engage validations
  validates :password, length: { in: 8..32 }

  # Define the only public method `#call`
  # where command's flow is defined
  def call
    # Use `return failure!` to exit from the command with failure
    return failure! if invalid?

    # Method `#transaction` is a shortcut for `ActiveRecord::Base.transaction`
    transaction do
      # Keep the `#call` method short and clean, put all the steps and actions
      # into meaningful and self-explanatory methods
      create_user

      # Use `error!` method to interrupt the flow raising an error
      error! unless @user.persistent?

      send_notification
      # ...
    end

    # Always end the `#call` method with `success!`
    # this will set the proper status and allow to chain command methods.
    success!
  end

  private

  def create_user
    @user = User.create(email: email, password: password)
  end

  def send_notification
    # ...
  end
end

### usage ###

class RegistrationsController
  def register
    cmd = RegisterUserCommand.call(params[:email], params[:password])

    if cmd.success?
     redirect_to user_path(cmd.user) and return
    else
      @errors = cmd.errors
    end
  end
end
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
