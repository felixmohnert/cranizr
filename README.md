# Cranizr

## How to use locally

* Checkout the repository
* Run `bundle install` while using Ruby 2.4.0
* Run `rails db:create` and `rails db:migrate`
* Start the server with `rails server`
* Run sidekiq with `bundle exec sidekiq -c 10`
* In order to run the job daily at 12 pm run `whenever --update-crontab`

### Additional requirements
* A local postgresql installation
* A local redis

### Specs
* Run `bundle exec rspec`

## Deployment on Heroku
