Logification
============

[![Gem Version](https://badge.fury.io/rb/logification.svg)](http://badge.fury.io/rb/logification) [![Build Status](https://travis-ci.org/NeMO84/logification.svg?branch=master)](https://travis-ci.org/NeMO84/logification) [![Dependency Status](https://gemnasium.com/NeMO84/logification.svg)](https://gemnasium.com/NeMO84/logification) [![Code Climate](https://codeclimate.com/github/NeMO84/logification/badges/gpa.svg)](https://codeclimate.com/github/NeMO84/logification) [![Test Coverage](https://codeclimate.com/github/NeMO84/logification/badges/coverage.svg)](https://codeclimate.com/github/NeMO84/logification)

Logification is an abstracted logging gem library. Its purpose is to simplyify and enhance logging. Some added benefits: wrapping, color coated output (terminal only) and more to come.

Logification's purpose is to enhance existing libraries by providing features on top of their general output. It currently makes an assumption that the base logging library supports the following levels debug, info, warn, error, fatal.

Logification has been integrated with the already very powerful Log4r. But future goals are to make it even less dependent on any specific logging library.

## Installation

Add this line to your application's Gemfile:

    gem 'logification'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install logification

## Usage

```ruby
require "logification"

# Nested logging (nested_tabbing is enabled by default)
Logification.logger.wrap("SomeTask", nested_tabbing: false) do |logger|

  logger.debug "Working on task1"
  logger.warn "Working on task2"

  # The below output should be nested
  logger.wrap("SomeSubTask") do |nested_logger|
    nested_logger.error "Working on sub task1"
    nested_logger.fatal "Working on sub task2"
  end

end

# Terminal output should be color coated
#=> 2014-09-08 18:19:14 INFO [logification] - Starting 'SomeTask':
#=> 2014-09-08 18:19:14 DEBU [logification] - Working on task1
#=> 2014-09-08 18:19:14 WARN [logification] - Working on task2
#=> 2014-09-08 18:19:14 INFO [logification] - Starting 'SomeSubTask':
#=> 2014-09-08 18:19:14 ERRO [logification] -     Working on sub task1
#=> 2014-09-08 18:19:14 FATA [logification] -     Working on sub task2
#=> 2014-09-08 18:19:14 INFO [logification] - Completed 'SomeSubTask' in 0.0s
#=> 2014-09-08 18:19:14 INFO [logification] - Completed 'SomeTask' in 0.0s

# Custom logging
# Assumes BasicLogger responds to above listed levels and 'level' method call
class BasicLogger
  attr_accessor :level
  def debug(msg); puts ["DEBUG", msg].join(" "); end
  def info(msg); puts ["INFO ", msg].join(" "); end
  def warn(msg); puts ["WARN ", msg].join(" "); end
  def error(msg); puts ["ERROR", msg].join(" "); end
  def fatal(msg); puts ["FATAL", msg].join(" "); end
end

logger = Logification::Logger.new(name: "myproject", base_logger: BasicLogger.new)
logger.debug "This should be color formatted now"
logger.wrap("ImagePostProcessing: 123", wrap_level: :debug) do |nested_logger|
  begin
    nested_logger.info "Image has been initialized"
    sleep(1) # resize
    nested_logger.warn "Image has been resized, but aspect ratio was not preserved"
    sleep(1) # upload
    nested_logger.fatal "Updated image has been uploaded"
  ensure
    nested_logger.error "A failure with the processing has happened"
  end
  nested_logger.fatal "This is a random fatal message"
end

# Terminal ouptut should be color coated
#=> DEBUG This should be color formatted now
#=> DEBUG Starting 'ImagePostProcessing: 123':
#=> INFO      Image has been initialized
#=> WARN      Image has been resized, but aspect ratio was not preserved
#=> FATAL     Updated image has been uploaded
#=> ERROR     A failure with the processing has happened
#=> FATAL     This is a random fatal message
#=> DEBUG Completed 'ImagePostProcessing: 123' in 2.001s
```

## TODO

  - Update README
  - Add error handling, logging should be conspicuous.
  - Remove dependency on log4r
  - Think up more TODO items
  - Make log level colors configurable
  - Improve testing by writing more micro functional tests


## Known Issues

TODO:


## Contributing

1. Fork it ( https://github.com/[my-github-username]/logification/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
