require "colorize"
require "log4r"

module Logification

  class Logger

    attr_accessor :base_logger
    attr_accessor :nested_count

    include Helpers::LoggingMethods
    include Helpers::Wrapper

    def initialize(options={})
      name = options[:name] || "logification"
      @base_logger = options[:logger] || default_logger(name)
    end

    def default_logger(name)
      Log4r::Logger.new(name).tap do |l|
        l.outputters = Log4r::Outputter.stdout.tap do |o|
          o.formatter = Log4r::PatternFormatter.new(pattern: "%d %.04l [%C] - %M")
        end
        l.level = Log4r::DEBUG
      end
    end

    def nested_count
      @nested_count ||= 0
    end

  end
end