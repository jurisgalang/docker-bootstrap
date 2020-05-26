# initial project configs

install and configure basic project dependencies and dev tools. 
note that these instructions were written based on `rails v6.0.3`

## add and configure testing dependencies

edit `Gemfile`:

```rb
# file: Gemfile
group :development, :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "factory_bot_rails"
  gem "rspec-rails"
end
```

edit `config/application.rb`:

```rb
# file: config/application.rb
module App
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end    
  end
end
```

install and configure dependencies:

```sh
docker-compose run --rm web bundle install
docker-compose run --rm web rails g rspec:install
```

## add and configure to use haml for view templates

edit `Gemfile`:

```rb
# file: Gemfile
gem "haml-rails", "~> 2.0"
```

install and configure dependencies:

```sh
docker-compose run --rm web bundle install
docker-compose run --rm web rails g haml:application_layout convert
docker-compose run --rm -e HAML_RAILS_DELETE_ERB=true web rails haml:erb2haml

rm web/app/views/layouts/application.html.erb
```

## check that rspec and haml is configured for the project

create a controller in dry-run (`--pretend`) mode:

```sh
docker-compose run --rm web rails g controller Pings show --no-helper \
  --no-assets --no-view-specs --pretend
```

if everything works correctly it should generate:

```sh
create  app/controllers/pings_controller.rb
 route  get 'pings/show'
invoke  haml
create    app/views/pings
create    app/views/pings/show.html.haml
invoke  rspec
create    spec/requests/pings_request_spec.rb
```
