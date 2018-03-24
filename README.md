[![Travis Build Status](https://travis-ci.org/Studiosity/fountain-ruby.svg?branch=master)](https://travis-ci.org/Studiosity/fountain-ruby)
[![Maintainability](https://api.codeclimate.com/v1/badges/0820e34b69a0dc3a7e8b/maintainability)](https://codeclimate.com/github/Studiosity/fountain-ruby/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0820e34b69a0dc3a7e8b/test_coverage)](https://codeclimate.com/github/Studiosity/fountain-ruby/test_coverage)
[![Gem Version](https://badge.fury.io/rb/fountain.svg)](https://badge.fury.io/rb/fountain)

# Fountain REST API for Ruby

This is a gem wrapping the v2 REST API for [Fountain](https://fountain.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fountain'
```

And then execute:

    $ bundle

## Supported API calls

#### Applicant Management
List, create, delete, get, update applicant etc

See https://developer.fountain.com/docs/applicants

## Usage

First, initialise the Fountain API token

```ruby
Fountain.configure do |config|
  config.api_token = 'YOUR-FOUNTAIN-API-TOKEN'
end
```

#### List all applicants
```ruby
applicants = Fountain::Api::Applicants.list
loop do
  break if applicants.count.zero?
  applicants.each do |applicant|
    # Do something with the applicant
  end
  applicants = Fountain::Api::Applicants.list(cursor: applicants.next_cursor)
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Studiosity/fountain-ruby.

Note that spec tests are appreciated to minimise regressions. Before submitting a PR, please ensure that:
 
```bash
$ rspec
```

and

```bash
$ rubocop
```

both succeed 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
