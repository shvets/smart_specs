# SmartSpecs - This tool helps to execute specs by pattern

## Installation

Add this line to to your Gemfile:

    gem "smart_specs"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart_specs

## Usage

    spec! user       - executes spec based on <user> pattern
    spec! user -l 65 - executes spec based on <user> pattern in line 65
    spec! --list     - displays list of all available specs
    spec! --list us  - displays list of available specs that satisfies <us> pattern

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request