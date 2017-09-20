source 'https://rubygems.org'

git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
    "https://github.com/#{repo_name}.git"
end

gem 'jquery-rails'
gem 'rails', '5.1.3'

# Use postgresql as the database for Active Record
gem 'pg', '0.20'

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Store secrets
gem 'figaro'

# Foundation for frontend
gem 'foundation-rails', '6.4.1.2'

# Auto-prefixing CSS for cross-browser compat.
gem 'autoprefixer-rails', '6.7.6'

# Use Slim as the templating engine. Better than ERB
gem 'slim'

# Transpile app-like JavaScript
gem 'foreman'
gem 'webpacker', '~> 3.0'
gem 'webpacker-react', '~> 0.3.1'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Background Jobs
gem 'redis-namespace'
gem 'sidekiq', '5.0.4'

# Model Serializers
gem 'active_model_serializers', '~> 0.10.0'
gem 'oj'
gem 'oj_mimic_json'

# Code analyzation
gem 'rubocop', '~> 0.49.1', require: false

# Parsing
gem 'watir', '6.8.1'
gem 'webdrivers', '~> 3.0'

group :development do
    gem 'capistrano', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano-rails', require: false
    gem 'capistrano-rvm', require: false
    gem 'capistrano-sidekiq', require: false
    gem 'listen', '~> 3.1.5'
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
    gem 'factory_girl_rails'
    gem 'rails-controller-testing'
    gem 'rspec-rails'
end

group :test do
    gem 'json_spec'
    gem 'shoulda-matchers'
end
