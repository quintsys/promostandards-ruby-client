# PromostandardsRubyClient

**promostandards-ruby-client** is an unofficial Ruby client for accessing
PromoStandards API services, designed to simplify integration with
PromoStandards data in Ruby applications.

## Installation

Add the gem to your Gemfile:

```ruby
gem 'promostandards-ruby-client'
```

Then, run:

```bash
bundle install
```

Or install it directly:

```bash
gem install promostandards-ruby-client
```

## Usage

The gem currently supports various PromoStandards API services, with a focus on
Product Data, Media Content, and Pricing services. Detailed usage instructions
and examples will be added here as the gem's functionality is expanded.

## Development

To get started with development, clone the repo and set up the dependencies:

```bash
bin/setup
```

To run the test suite:

```bash
rake spec
```

You can use `bin/console` to start an interactive session and experiment with
the library.

To build and install the gem locally:

```bash
bundle exec rake install
```

For releasing a new version:

1. Update the version in `version.rb`.
2. Run `bundle exec rake release` to push the new version to GitHub and
   RubyGems.

## Contributing

Bug reports and pull requests are welcome on GitHub at
[https://github.com/quintsys/promostandards-ruby-client](https://github.com/quintsys/promostandards-ruby-client).
This project aims to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[code of conduct](https://github.com/quintsys/promostandards-ruby-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Promostandards::Ruby::Client project's codebases,
issue trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/quintsys/promostandards-ruby-client/blob/master/CODE_OF_CONDUCT.md).
