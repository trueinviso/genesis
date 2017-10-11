source "https://rubygems.org"
ruby "2.4.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "awesome_print"
gem "aws-sdk", "~> 2.1"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
gem "devise"
gem "font-awesome-rails"
gem "forgery"
gem "foundation-rails"
gem "haml", git: "https://github.com/haml/haml"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "oauth2"
# Use postgres as the database for Active Record
gem "pg"
# Use Puma as the app server
gem "puma", "~> 3.7"
gem "pundit"
# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1.1"
gem "rails-controller-testing"
gem "roda"
gem "sass"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
gem "seed-fu", "~> 2.3"
### Shrine gems ###
gem "shrine"
gem "stripe"
gem "stripe_event"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "dotenv-rails"
  gem "factory_girl_rails", "~> 4.8"
  gem "rspec-rails", "~> 3.6"
  gem "selenium-webdriver"
  # Collection of testing matchers
  gem "shoulda-matchers",
    git: "https://github.com/thoughtbot/shoulda-matchers.git",
    branch: "rails-5"
  gem "stripe-ruby-mock", "~> 2.5.0", require: "stripe_mock"
  gem "webmock"
end

group :development do
  gem "capistrano", "~> 3.7", ">= 3.7.1"
  gem "capistrano-passenger", "~> 0.2.0"
  gem "capistrano-rails", "~> 1.2"
  gem "capistrano-rvm"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
