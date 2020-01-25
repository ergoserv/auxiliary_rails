# Gemfile cleanup
gsub_file 'Gemfile', /^\s*#.*$\n/, ''
gsub_file 'Gemfile', /^.*coffee.*$\n/, ''
gsub_file 'Gemfile', /^.*jbuilder.*$\n/, ''
gsub_file 'Gemfile', /^.*tzinfo-data.*$\n/, ''
gsub_file 'Gemfile', /^group :development, :test do\n.*byebug.*\nend\n\n/, ''

# Create RuboCop files
file '.rubocop.yml', <<~FILE
  inherit_gem:
    rubocop-ergoserv:
      - config/default.yml

FILE

file 'bin/rubocop', <<~FILE
  #!/usr/bin/env bash

  bundle exec rubocop "$@"

FILE

chmod 'bin/rubocop', 0o755

# Gemfile additions
gem 'auxiliary_rails'

gem_group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-ergoserv',
    git: 'https://github.com/ergoserv/rubocop-ergoserv',
    require: false
end

gem_group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

after_bundle do
  # ensure using the latest versions of gems
  run 'bundle update'
  rails_command 'generate rspec:install'
end
