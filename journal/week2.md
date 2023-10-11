# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby.
It is the primary way to install ruby packages, known as gems.

### Install Gems
Need to create a `Gemfile` and define gems in the file

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then run `bundle install`

This will install gems globally, unlike nodejs which installs in place in a folder called node_modules

A Gemfile.lock will be created to lock down the hem versions used in the project.

### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra 
Sinatra is a micro-web framework for ruby to build web-apps.

## Terratowns mock server

### Running the server

We cab ryb tge server by executing the following commands:

```rb
bundle install
bundle exec ruby.server.rb
```

All of the code for our server is stored in the `server.rb`

