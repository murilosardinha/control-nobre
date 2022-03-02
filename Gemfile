source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'rails', '7.0.1'

gem "pg", "1.1.4"
gem 'puma', '~> 3.11'

gem 'bootstrap', '5.1.3'
gem "font-awesome-sass", "5.13.0"
gem 'sass-rails', '~> 5.0'
gem 'haml'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
# gem 'jquery_mask_rails'
# gem 'jquery-inputmask-rails'

gem "devise", "4.8.1"
gem "devise-bootstrap-views"
gem "devise-i18n", "1.6.1"

gem 'bootstrap4-kaminari-views'
gem 'kaminari'
gem 'kaminari-i18n'

gem "roo", "2.7.1"
gem "roo-xls", "1.2.0"

# gem "httparty"
gem "sidekiq", "6.4.1"

# gem "rubyzip"
gem 'caxlsx'
gem 'caxlsx_rails'

gem "chartkick", '3.3.2'
gem "ransack", '2.5.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'pundit', '2.0.1'

gem 'rack-cors'

gem 'barby', '0.6.8'
gem 'rqrcode', '2.1.1'
gem 'chunky_png', '1.4.0'

source "https://rails-assets.org" do
  gem "rails-assets-angular", "1.6.6"
  gem "rails-assets-angular-resource", "1.6.6"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "better_errors"
  gem "binding_of_caller"  
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '4.0.0'
  gem 'rails_real_favicon'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]