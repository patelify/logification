require "logification/version"
require "logification/helpers"
require "logification/logger"

module Logification

  class << self

    attr_accessor :logger

    def logger
      @logger ||= begin
        Logification::Logger.new.tap do |l|
          l.level = :debug
        end
      end
    end

    def level=(lvl)
      logger.level = lvl
    end

    def level
      logger.level
    end

  end

end
