require "colorize"
require "log4r"

module Logification

  class Logger

    attr_accessor :base_logger

    def initialize(options={})
      name = options[:name] || "logification"
      @base_logger = options[:logger] || default_logger(name)
    end

    def debug(msg=nil)
      msg = yield if block_given?
      log_message(:debug, msg, :green)
    end

    def info(msg=nil)
      msg = yield if block_given?
      log_message(:info, msg, :cyan)
    end

    def warn(msg=nil)
      msg = yield if block_given?
      log_message(:warn, msg, :yellow)
    end

    def error(msg=nil)
      msg = yield if block_given?
      log_message(:error, msg, :red)
    end

    def fatal(msg=nil)
      msg = yield if block_given?
      log_message(:fatal, msg, :magenta)
    end

    private

    def log_message(type, msg, color)
      msg = messagify(msg)
      base_logger.send(type, msg.to_s.send(color))
      msg
    end

    def default_logger(name)
      Log4r::Logger.new(name).tap do |l|
        l.outputters = Log4r::Outputter.stdout.tap do |o|
          o.formatter = Log4r::PatternFormatter.new(pattern: "%d %l [%C] - %M")
        end
        l.level = Log4r::DEBUG
      end
    end

    def messagify(msg)
      msg
    end

  end
end