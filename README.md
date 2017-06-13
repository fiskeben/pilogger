# PiLogger

A Restful API for logging data points with IoT dingii.

## Installation and running

TBA but it's a Ruby on Rails app so try:

* `$ bundle install`
* `rails s`

For deployment you might be interested in running with Docker, like so:

````
$ docker build -t pilogger .
$ docker run -d --name pilogger -p 8080:80 -e "SECRET_KEY_BASE=<your super secret key>" -e "SECRET_TOKEN=<also something super secret>" pilogger
````

Please note that this uses an Sqlite3 database which gets written to disk inside the Docker container. You don't want that so consider mounting a volume where it can live or configure the app to use another database.

# License

MIT
