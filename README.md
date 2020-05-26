# docker-bootstrap

Bootstrapper for Docker-based projects using Rails with nginx and PostgreSQL DB.

[![GitHub Actions](https://github.com/jurisgalang/docker-bootstrap/workflows/CI/badge.svg?style=for-the-badge)](https://github.com/jurisgalang/docker-bootstrap/actions)

## Requires

- docker `v19.03.8`
- docker-compose `v1.25.5`

## Usage

The following steps will create the Docker images and setup a Rails project 
using the PostgreSQL DB.

```sh
# shallow clone bootstrap files and re-init the repo
$ git clone --depth 1 git@github.com:jurisgalang/docker-bootstrap.git project-name
$ cd project-name/
$ rm -rf .git .github
$ git init

# build images
$ docker-compose build

# install rails in web container and create a project using postgresql 
$ docker-compose run --rm web gem install bundler rails
$ docker-compose run --rm web rails new . -d postgresql --skip-test

# create posgresql db config
$ tee ./web/config/database.yml << 'EOF'
default: &default
  adapter: postgresql
  encoding: unicode
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>
  host: <%= ENV['DATABASE_HOST'] %>
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>

development:
  <<: *default
  database: app_development

test:
  <<: *default
  database: app_test

production:
  <<: *default
  database: app_production
EOF

# initialize project db
$ docker-compose run --rm web rake db:create
$ docker-compose run --rm web rake db:migrate
$ docker-compose run --rm web rake db:setup

# spin-up web app and test
$ docker-compose run --rm --service-ports web
$ curl -I http://localhost:3000/ 

# spin-up nginx to serve the web app and test
$ docker-compose run --rm --service-ports nginx
$ curl -I http://localhost/ 
```

The Rails project resides at `./web`; after the setup and verification its 
`Dockerfile` will need to be updated for project specific requirements and to 
make it suitable for deployment.

## Housekeeping

To clear all containers, images, and volume:
```sh
$ docker-compose down
$ docker system prune -a
$ docker volume prune
```
