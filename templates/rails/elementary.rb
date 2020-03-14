# Gemfile cleanup
gsub_file 'Gemfile', /^\s*#.*$\n/, ''
gsub_file 'Gemfile', /^.*coffee.*$\n/, ''
gsub_file 'Gemfile', /^.*jbuilder.*$\n/, ''
gsub_file 'Gemfile', /^.*tzinfo-data.*$\n/, ''
gsub_file 'Gemfile', /^group :development, :test do\n.*byebug.*\nend\n\n/, ''

gsub_file '.gitignore', /^\s*#.*$\n/, ''
gsub_file 'config/routes.rb', /^\s*#.*$\n/, ''

gsub_file 'config/database.yml', /^\s*#.*$\n/, ''
gsub_file 'config/database.yml', /^\s*pool.*$\n/, <<-FILE
  host: <%= ENV['DATABASE_HOST'] %>
  username: <%= ENV['DATABASE_USERNAME'] %>
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
FILE

# Create RuboCop files
file '.rubocop.yml', <<~FILE
  inherit_gem:
    rubocop-ergoserv:
      - config/default.yml
FILE

run 'touch .env'
append_file '.gitignore', <<~FILE
  .env*.local
FILE

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
  run 'bundle binstubs rubocop'

  generate :controller, 'pages', 'home',
    '--no-assets',
    '--no-helper',
    '--no-test-framework',
    '--skip-routes'
  route "root to: 'pages#home'"

  generate 'rspec:install'
end
