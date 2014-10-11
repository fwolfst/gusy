# Gusy

A padrino gem, eventually showing seminars for the ecovillage Sieben Linden homepage.

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

