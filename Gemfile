source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
gem 'pg', '0.21.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'aasm'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# gem 'bootstrap'
# gem 'bootstrap-sass'
gem 'colorize'
gem 'redcarpet'
gem 'haml'
gem 'simple_form'
gem 'devise'
gem "omniauth-oauth2"
gem 'jquery-ui-rails'
gem "paperclip", "~> 5.0.0"
gem 'paperclip-av-transcoder'
gem 'kaminari'
gem 'jquery-fileupload-rails'
gem 'chart-js-rails'
gem 'week_of_month'
gem 'materialize-sass'
gem 'material_icons'
gem 'rubocop'
gem "jquery-slick-rails"
gem 'tinymce-rails'
gem 'date_validator'
gem 'flipclockjs-rails'
gem "paranoia"
gem 'gon'
gem 'awesome_print'
gem 'aasm'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'magick_title', '>= 0.2.0'
gem 'imgkit'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'pdfkit'
gem 'faker'
gem 'dotenv-rails'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'redis'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :production do
end

group :development do

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Para que se muestre en la consola del servidor las cosas que yo indique en los controladores
  gem "pry-rails"
  gem 'pry-nav'
  # Mostrar por consola los datos en una tabla
  gem "table_print"
  gem 'rspec-rails'
  gem 'spring-commands-rspec'

  gem 'spring-watcher-listen', '~> 2.0.0'
end

# group :test do
#   gem 'capybara'
#   gem 'cucumber-rails', require: false
#   gem 'database_cleaner'
#   gem 'rails-controller-testing'
#   gem 'shoulda-matchers', require: false
#   gem 'vcr'
#   gem 'webmock'
# end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
