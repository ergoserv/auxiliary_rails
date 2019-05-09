# Gemfile cleanup
gsub_file 'Gemfile', /^\s*#.*$\n/, ''
gsub_file 'Gemfile', /^.*coffee.*$\n/, ''
gsub_file 'Gemfile', /^.*jbuilder.*$\n/, ''
gsub_file 'Gemfile', /^.*tzinfo-data.*$\n/, ''

gem 'auxiliary_rails',
  git: 'https://github.com/ergoserv/auxiliary_rails',
  branch: 'develop'

gem_group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'rspec-rails'
end

gem_group :test do
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

after_bundle do
  # ensure using the latest versions of gems
  run 'bundle update'
  rails_command 'generate auxiliary_rails:install_rubocop --no-specify-gems'
  rails_command 'generate rspec:install'
end
