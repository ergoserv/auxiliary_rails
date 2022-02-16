# AuxiliaryRails

Collection of classes, configs, scripts, generators for Ruby on Rails helping you get things done, better.

[![Gem](https://img.shields.io/gem/v/auxiliary_rails.svg)](https://rubygems.org/gems/auxiliary_rails)
[![Build Status](https://travis-ci.org/ergoserv/auxiliary_rails.svg?branch=master)](https://travis-ci.org/ergoserv/auxiliary_rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/a317c4893a804ce577ab/maintainability)](https://codeclimate.com/github/ergoserv/auxiliary_rails/maintainability)

## Installation

Add one of these lines to your application's `Gemfile`:

```ruby
# version released to RubyGems (recommended)
gem 'auxiliary_rails'

# or latest version from the repository
gem 'auxiliary_rails', git: 'https://github.com/ergoserv/auxiliary_rails'
# or from a specific branch of the GitHub repository
gem 'auxiliary_rails', github: 'ergoserv/auxiliary_rails', branch: 'develop'
# or from a local path (for development and testing purposes)
gem 'auxiliary_rails', path: '../auxiliary_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auxiliary_rails

## Usage

- [API documentation](https://www.rubydoc.info/gems/auxiliary_rails)

### Rails Application Templates

Install gem into the system (e.g. using `gem install auxiliary_rails`) then:

```sh
auxiliary_rails new APP_PATH
# or add `--develop` option to pull the most recent template from repository
auxiliary_rails new APP_PATH --develop
```

Or use `rails new` command specifying `--template` argument:

```sh
rails new APP_PATH --database=postgresql --template=https://raw.githubusercontent.com/ergoserv/auxiliary_rails/develop/templates/rails/elementary.rb --skip-action-cable --skip-coffee --skip-test
```

### Generators

```sh
# Install everything at once
rails generate auxiliary_rails:install

# Install one by one
rails generate auxiliary_rails:install_commands
rails generate auxiliary_rails:install_errors
rails generate auxiliary_rails:install_errors_controller

# API resource generator
rails generate auxiliary_rails:api_resource

# Command generator
rails generate auxiliary_rails:command
```

### Command Objects

Variation of implementation of [Command pattern](https://en.wikipedia.org/wiki/Command_pattern).

Read post [Command Objects - a.k.a Service Objects in Ruby on Rails - The Ergonomic Way](https://www.ergoserv.com/blog/command-objects-aka-service-objects-in-ruby-on-rails-the-ergonomic-way) for more details.

```ruby
# app/commands/application_command.rb
class ApplicationCommand < AuxiliaryRails::Application::Command
end

# app/commands/register_user_command.rb
class RegisterUserCommand < ApplicationCommand
  # Define command arguments
  # using `param` or `option` methods provided by dry-initializer
  # https://dry-rb.org/gems/dry-initializer/3.0/
  param :email
  param :password

  # Define the results of the command using `attr_reader`
  # and set it as a regular instance var inside the command
  attr_reader :user

  # Regular Active Model Validations can be used to validate params
  # https://api.rubyonrails.org/classes/ActiveModel/Validations.html
  # Use #valid?, #invalid?, #validate! methods to engage validations
  validates :password, length: { in: 8..32 }

  # Define the only public method `#perform` where command's flow is defined
  def perform
    # Use `return failure!` and `return success!` inside `#perform` method
    # to control exits from the command with appropriate status.

    # Use `return failure!` to exit from the command with failure
    return failure! if registration_disabled?

    # Method `#transaction` is a shortcut for `ActiveRecord::Base.transaction`
    transaction do
      # Keep the `#perform` method short and clean, put all the steps, actions
      # and business logic into meaningful and self-explanatory methods
      @user = create_user

      # Use `error!` method to interrupt the flow raising an error
      error! unless user.persistent?

      send_notifications
      # ...
    end

    # Always end the `#perform` method with `success!`.
    # It will set the proper command's execution status.
    success!
  end

  private

  def create_user
    User.create(email: email, password: password)
  end

  def send_notifications
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

    ### OR ###

    RegisterUserCommand.call(params[:email], params[:password])
      .on(:success) do
        redirect_to dashboard_path and return
      end
      .on(:failure) do |cmd|
        @errors = cmd.errors
      end
  end
end
```

### Form Objects

```ruby
# app/forms/application_form.rb
class ApplicationForm < AuxiliaryRails::Application::Form
end

# app/forms/company_registration_form.rb
class CompanyRegistrationForm < ApplicationForm
  # Define form attributes
  attribute :company_name, :string
  attribute :email, :string

  # Define form submission results
  attr_reader :company

  # Regular Active Model Validations can be used to validate attributes
  # https://api.rubyonrails.org/classes/ActiveModel/Validations.html
  validates :company_name, presence: true
  validates :email, email: true

  def perform
    # Perform business logic here

    # Use `attr_reader` to expose the submission results.
    @company = create_company
    # Return `failure!` to indicate failure and stop execution
    return failure! if @company.invalid?

    send_notification if email.present?

    # Always end with `success!` method call to indicate success
    success!
  end

  private

  def create_comany
    Company.create(name: company_name)
  end

  def send_notification
    # mail to: email
  end
end

### Usage ###

form = CompanyRegistrationForm.call(params[:company])
if form.success?
  redirect_to company_path(form.company) and return
else
  @errors = form.errors
end
```

### Query Objects

```ruby
# app/queries/application_query.rb
class ApplicationQuery < AuxiliaryRails::Application::Query
end

# app/queries/authors_query.rb
class AuthorsQuery < ApplicationQuery
  default_relation Author.all

  option :name_like, optional: true
  option :with_books, optional: true

  def perform
    if recent == true
      # equivalent to `@query = @query.order(:created_at)`:
      query order(:created_at)
    end

    if name_like.present?
      query with_name_like(name_like)
    end
  end

  private

  def with_name_like(value)
    where('authors.name LIKE ?', "%#{value}%")
  end
end

# app/queries/authors_with_books_query.rb
class AuthorsWithBooksQuery < AuthorsQuery
  option :min_book_count, default: { 3 }

  def perform
    query joins(:books)
      .group(:author_id)
      .having('COUNT(books.id) > ?', min_book_count)
  end
end

### Usage ###

# it is possible to wrap query object in a scope and use as a regular scope
# app/models/author.rb
class Author < ApplicationRecord
  scope :name_like, ->(value) { AuthorsQuery.call(name_like: value) }
end

authors = Author.name_like('Arthur')

# or call query directly
authors = AuthorsWithBooksQuery.call(min_book_count: 10)
```

### View Helpers

```ruby
current_controller?(*ctrl_names)
current_action?(*action_names)
display_name(resource)
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
