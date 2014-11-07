# Gusy

A padrino gem, showing seminars for the ecovillage Sieben Linden homepage.
On the way to a real "GUestSYstem".
Except for a twist in registration creation (where data also is pushed to a legacy system using a CouchDB) the gusy solution should be rather general.  If you want to abstract from this, send us a line, it should not be too difficult to sort it out.

## Usage

Add the following to your `Gemfile`:

```ruby
  gem 'gusy'
```

and mount the app in your `apps.rb`:

```ruby
  Padrino.mount("Gusy::App").to("/gusy")
```

## Development

For development, this gem can be run as a standalone Padrino application
as you would expect from a normal one:

```ruby
$ bundle exec padrino start
```

The Rakefile also works like the normal Padrino one and supports all standard
components.

For Spec/Testing, a test db has to be set up and seeded.  This is done via
```
  rm db/gusy_test.db
  padrino rake -e test sq:migrate
  padrino rake -e test db:seed
```

You can also use that seed data during development, with
```
  rm db/gusy_development.db
  padrino rake -e development sq:migrate
  padrino rake -e development db:seed
```

## Deployment

Like any other standard sinatra/padrino/rack app.

Here I will sketch an involved example for a debian system with apache and phusion passenger and a user with restricted rights (say, 'gusy').

 * Install `rvm`.
 * Configure passenger.conf to point to the rvm ruby, like
    PassengerDefaultRuby /home/gusy/.rvm/gems/ruby-2.0.0-p481/wrappers/ruby
 * Checkout gusy (the much cleaner gem install path is not yet walked upon), e.g. to /home/gusy/production)
 * Create a VirtualHost in apache config files, point
    DocumentRoot /home/gusy/production
    ErrorLog /var/log/apache2/gusy.production.error.log
 * Also specify the (/public) directory and
    Allow from all
    Options -MultiViews
 * Ensure that the database is populated.
