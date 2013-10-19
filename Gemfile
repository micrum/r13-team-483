source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'figaro'
gem 'mysql2'
gem 'slim-rails'
gem 'codemirror-rails'

gem 'capistrano', '~> 2.15'

gem 'daemons'
gem 'delayed_job_active_record'

group :development do
  gem 'puma'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'fabrication'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
end

group :production do
  gem 'therubyracer'
end
