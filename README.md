# MERCADINHO RAILS APP

## Requirements

* [Git](https://git-scm.com/)
* [Docker](https://www.docker.com)


## Stack

* [Ruby 2.1.10](https://www.ruby-lang.org/)
* [Rails 4.1.12](http://rubyonrails.org/)
* [PostgreSQL 9.4.12](https://www.postgresql.org/)


## Running application from source

You can run the application using these commands:

```sh
$ git clone git@github.com:corujito/mercadinho.git
$ cd mercadinho
$ docker-compose build
$ docker-compose up -d
$ docker-compose run --rm app rake db:create db:migrate db:seed
```


## Cleaning

Stop/Remove containers and images

```sh
$ docker-compose down
$ docker rmi mercadinho_app postgres
```


## Check it out

Go to http://localhost:3000 and login with user and password "corujito"

Try to create a new order to client Antonio da Costa with some products (ex: Coca Cola) at http://localhost:3000/orders/new


## if you still don't use docker :(

```sh
install ruby 2.1.10
install postgres 9.4.12
$ git clone git@github.com:corujito/mercadinho.git
$ cd mercadinho
$ bundle install
$ rake db:create db:migrate db:seed
$ rails s
```