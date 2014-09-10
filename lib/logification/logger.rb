require "colorize"
require "log4r"

# http://stackoverflow.com/questions/5799823/ruby-uninitialized-constant-log4rdebug-nameerror-problem/5800326#5800326
Log4r.define_levels(*Log4r::Log4rConfig::LogLevels)

module Logification

  class Logger

    attr_accessor :name, :base_logger, :nested_count

    include Helpers::LoggingMethods
    include Helpers::Wrapper

    def initialize(options={})
      self.name = options[:name] || "logification"
      self.base_logger = options[:base_logger] || default_logger(@name)
      self.nested_count = options[:nested_count] || 0
      self.level = options[:level] || :debug
    end

    def default_logger(name)
      Log4r::Logger.new(name).tap do |l|
        l.outputters = Log4r::Outputter.stdout.tap do |o|
          o.formatter = Log4r::PatternFormatter.new(pattern: "%d %.04l [%C] - %M")
        end
        l.level = translate_level(:debug)
      end
    end

    def nested_count
      @nested_count ||= 0
    end

    def level
      LOG4R_LEVEL_TRANSLATION.key(base_logger.level)
    end

    def level=(value)
      base_logger.level = translate_level(value)
      @level = value
    end

    def duplicate(name, options={})
      settings = current_settings.merge(options)
      self.class.new(settings.merge(name: name))
    end

  private

    def current_settings
      {
        name: self.name,
        level: self.level,
        nested_count: self.nested_count
      }
    end

    LOG4R_LEVEL_TRANSLATION = {
      :debug => 1,
      :info => 2,
      :warn => 3,
      :error => 4,
      :fatal => 5
    }

    def translate_level(lvl)
      LOG4R_LEVEL_TRANSLATION[lvl.to_s.to_sym]
    end

  end
end