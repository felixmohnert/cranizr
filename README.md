# Cranizr

## How to use locally

* Checkout the repository
* Run `bundle install` while using Ruby 2.4.0
* Run `rails db:create` and `rails db:migrate`
* Start the server with `rails server`
* Run sidekiq with `bundle exec sidekiq -c 10`
* To fill the database the first time, run: `bundle exec rake fetch_r_packages_at_12pm`
* In order to run the job daily at 12 pm, run: `whenever --update-crontab`

### Additional requirements
* A local postgresql installation
* A local redis

### Specs
* Run `bundle exec rspec`

## Deployment on Heroku

* Follow the instructions for a Rails 5 application
* Run `heroku run rake db:migrate`
* Setup a Heroku Scheduler to run the task `fetch_r_packages_at_12pm`

Please be aware, that on the free plan, the resources on Heroku are not sufficient to handle the high number of packages.
