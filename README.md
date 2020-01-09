# Cdigits

[![Build Status](https://travis-ci.org/kengos/cdigits.svg?branch=master)](https://travis-ci.org/kengos/cdigits)

Cdigits implements Luhn N algorithm.

usage                     | N  | valid characters | example |
------------------------- | -- | ---------------- | ------- |
Cdigit::Luhn.number       | 10 | 0 to 9          | 8217161655 |
Cdigit::Luhn.hex          | 16 | 0 to 9 and a to f | e780dcc9c9 |
Cdigit::Luhn.alphanumeric | 36 | 0 to 9 and a to z | 6lgoybfzvr |
Cdigit::Luhn.easy         | 30 | 0 to 9 and A to Z without D / I / M / O / Q / Z | U1B3J0SCG8

Also, you can generate code in any format using placeholder.

example:

```rb
Cdigits::Luhn.number 'CA##-####-####-###?' # => "CA66-6567-2324-6526"
Cdigits::Luhn.number '2020-01##-####-###?' # => "2020-0160-1171-1643"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cdigits'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cdigits

## Usage

### Generate code

```rb
placeholder = 'CA##-####-####-###?'
Cdigits::Luhn.number
# => "6907562414"
Cdigits::Luhn.number placeholder
# => "CA98-4890-6337-4381"
Cdigits::Luhn.hex
# => "2c14a42508"
Cdigits::Luhn.hex placeholder
# => "CA27-675e-7136-5fa1"
Cdigits::Luhn.alphanumeric
# => "yrkxeh4eie"
Cdigits::Luhn.alphanumeric placeholder
# => "CA59-bdxv-wjei-gdc9"
Cdigits::Luhn.easy
# => "16TPF8RETL"
Cdigits::Luhn.easy placeholder
# => "CABW-LF40-G11S-TL3U"
```

#### Special chars in placeholder

- `+` ... non-zero random number (1 to modulus)
- `#` ... random number (0 to modulus)
- `?` ... check digit

### Validate code

```
Cdigits::Luhn.number? '6907562414'
# => true
Cdigits::Luhn.hex? '2c14a42508'
# => true
Cdigits::Luhn.alphanumeric? 'yrkxeh4eie'
# => true
Cdigits::Luhn.easy? '16TPF8RETL'
# => true
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kengos/cdigits. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kengos/cdigits/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cdigits project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kengos/cdigits/blob/master/CODE_OF_CONDUCT.md).
