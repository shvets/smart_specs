# SmartSpecs - This script

## Installation

Add this line to your application's Gemfile:

    gem 'script_executor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install script_executor

## Usage

     spec! user       - executes spec based on <user> pattern
     spec! user -l 65 - executes spec based on <user> pattern in line 65
     spec! --list     - displays list of all available specs
     spec! --list us  - displays list of available specs that satisfy <us> pattern

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request