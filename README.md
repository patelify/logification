Logification [![Build Status](https://travis-ci.org/NeMO84/logification.svg?branch=master)](https://travis-ci.org/NeMO84/logification) [![Dependency Status](https://gemnasium.com/NeMO84/logification.svg)](https://gemnasium.com/NeMO84/logification) [![Code Climate](https://codeclimate.com/github/NeMO84/logification/badges/gpa.svg)](https://codeclimate.com/github/NeMO84/logification) [![Test Coverage](https://codeclimate.com/github/NeMO84/logification/badges/coverage.svg)](https://codeclimate.com/github/NeMO84/logification)
============

Logification is an abstracted logging gem library. Its purpose is to not only simply logging, but also to enhance. Some added benefits: wrapping, color coating output (terminal only for now) and more to come.

Logification's purpose to enhance existing libraries. It assumes that existing logging library support the following levels debug, info, warn, error, fatal.

Currently, logification has been integrated with Log4r. But future goals are to make it even more abstract so there is no dependency on one specific library.

## Installation

Add this line to your application's Gemfile:

    gem 'logification'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install logification

## Sample Usage

```rubys
require "logification"

# Nested logging (nested_tabbing is enabled by default)
Logification.logger.wrap("SomeTask", nested_tabbing: false) do |logger|

  logger.debug "Working on task"
  logger.warn "Working on task"

  # The below output should be nested
  logger.wrap("SomeSubTask") do |nested_logger|
    nested_logger.error "Working on sub task"
    nested_logger.fatal "Working on sub task"
  end

end

# Custom logging
# Assumes BasicLogger responds to above listed levels and 'level' instance method call)
class BasicLogger
  attr_accessor :level
  def debug(msg); puts msg; end
  def info(msg); puts msg; end
  def warn(msg); puts msg; end
  def error(msg); puts msg; end
  def fatal(msg); puts msg; end
end

logger = Logification::Logger.new(name: "myproject", base_logger: BasicLogger.new)
logger.debug "This should be color formatted now"
logger.wrap("ImagePostProcessing: 123") do |nested_logger|
  nested_logger.debug "Image has been initialized"
  sleep(1) # resize
  nested_logger.debug "Image has been resized"
  sleep(1) # upload
  nested_logger.debug "Updated image has been uploaded"
end
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
