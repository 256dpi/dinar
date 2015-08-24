# Dinar

_This project is not maintained anymore._

A simple rails locale managment system.

## Installation

Currently the gem is only available over github:

```ruby
gem 'dinar', github: '256dpi/dinar'
```

## Usage

### Setup

Use the generator to setup dinar:

    $ rails g dinar:install en de es it

The first language key is the source language (master), all others are target languages to translate to.

A `config/dinar.yml` gets created to transparently hold the configuration.
