# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "alias_method_chain"
gem "bcrypt", "~> 3.0"
gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"
gem "pg"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.4"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "simple_form_bootstrap3"
gem "slim"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "warden", "~> 1.2"
gem "grape"
gem "grape-entity"
gem "dry-validation"
# gem "dry-types"
gem "pundit"
gem "reform"
gem "rolify"
gem "trailblazer"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "guard"
  gem "guard-bundler", require: false
  gem "guard-rspec", require: false
  gem "guard-rubocop", require: false
  gem "pry-byebug"
  gem "pundit-matchers", "~> 1.4.1"
  gem "reek"
  gem "rspec-rails", "~> 3.6"
  gem "rubocop-rails"
  gem "selenium-webdriver"
  # Needed for the optional matcher
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers"
end

group :development do
  gem "growl"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
