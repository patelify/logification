require "logification/version"
require "logification/logger"

# http://stackoverflow.com/questions/5799823/ruby-uninitialized-constant-log4rdebug-nameerror-problem/5800326#5800326
Log4r.define_levels(*Log4r::Log4rConfig::LogLevels)

module Logification

  class << self

    attr_accessor :logger

    def logger
      @logger ||= begin
        Logification::Logger.new.tap do |l|
          l.base_logger.level = translate_level(:debug)
        end
      end
    end

    def level=(lvl)
      logger.base_logger.level = @level = translate_level(lvl)
    end

    def level
      LOG4R_LEVEL_TRANSLATION_REVERSE[logger.base_logger.level]
    end

  private

    LOG4R_LEVEL_TRANSLATION = {
      :debug => Log4r::DEBUG,
      :info => Log4r::INFO,
      :warn => Log4r::WARN,
      :error => Log4r::ERROR,
      :fatal => Log4r::FATAL
    }

    LOG4R_LEVEL_TRANSLATION_REVERSE = {
      1 => :debug,
      2 => :info,
      3 => :warn,
      4 => :error,
      5 => :fatal
    }

    def translate_level(lvl)
      LOG4R_LEVEL_TRANSLATION[lvl]
    end

  end

end
