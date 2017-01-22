source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'treetop-dcf'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3'
end

group :test do
  gem 'rails-controller-testing'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'whenever', require: false
end

ruby '2.4.0'
