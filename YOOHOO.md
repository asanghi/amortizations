# Amortizations

Amortizations is a Ruby gem that simplifies the process of generating various types of loan amortization schedules. It supports a wide range of amortization types, including standard, interest-only, balloon, and more. This gem is designed to be flexible, easy to use, and compatible with Rails and other Ruby applications.

## Features

- Support for multiple amortization types
- Easy-to-use interface
- Built-in validations
- Compatible with Rails and other Ruby applications
- Calculating Internal Rate of Return (IRR)

## Installation

Add this line to your application's Gemfile:

gem 'amortizations'

And then execute:

$ bundle install

Or install it yourself as:

$ gem install amortizations

## Usage

To use the Amortizations gem, start by requiring it in your code:

require 'amortizations'

Then, create an amortization instance using the provided factory:

amortization = Amortizations::AmortizationFactory.build(
  'standard',
  finance_amount: 100000,
  interest_rate: 5.0,
  tenure: 360
)

You can generate the amortization schedule by calling the `generate_schedule` method:

schedule = amortization.generate_schedule

To calculate the Internal Rate of Return (IRR) based on the generated schedule:

irr = amortization.calculate_irr

### Supported Amortization Types

The following amortization types are supported:

- Standard (fixed principal and interest payments)
- Interest-only (interest-only payments for a specified period, followed by fixed principal and interest payments)
- Balloon (regular fixed payments followed by a large lump-sum payment)
- ... (additional types can be added as needed)

To create an amortization instance for a specific type, pass the corresponding type string as the first argument to the `Amortizations::AmortizationFactory.build` method.

## Contributing

We welcome contributions to the Amortizations gem! To contribute, please follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch for your changes.
3. Implement your changes and add tests.
4. Submit a pull request with a description of your changes.

Please ensure that your code adheres to our coding standards and that tests are provided for any new functionality.

## License

The Amortizations gem is released under the MIT License.

## Acknowledgments

A special thank you to everyone who has contributed to the development of the Amortizations gem!

