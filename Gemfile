source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '~> 4.4.3'
gem "aws-sdk-s3", '~> 1.17.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner', '~> 1.7.0'
  gem 'factory_bot', '~> 4.10.0'
  gem 'pry-rails', '~> 0.3.6'
  gem 'rspec-rails', '~> 3.7'
  gem 'parallel_tests', '~> 2.21.3'
  gem 'terminal-notifier', '~> 2.0.0'
  gem 'timecop', '~> 0.9.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
