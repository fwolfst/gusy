# Gusy

A padrino gem, showing seminars for the ecovillage Sieben Linden homepage.

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
