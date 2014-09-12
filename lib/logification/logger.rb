require "logger"

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
      ::Logger.new(STDOUT).tap do |l|
        l.level = translate_level_in(:debug)
        l.formatter = Logification::Formatters::Colorized.new
        l.progname = self.name
      end
    end

    def nested_count
      @nested_count ||= 0
    end

    def level
      translate_level_out(base_logger.level)
    end

    def level=(value)
      base_logger.level = translate_level_in(value)
    end

    def duplicate(name, options={})
      settings = current_settings.merge(options)
      self.class.new(settings.merge(name: name))
    end

    def method_missing(meth, *args, &block)
      begin
        if block_given?
          if args.empty?
            base_logger.send(meth) { block }
          else
            base_logger.send(meth, *args, &block)
          end
        else
          if args.empty?
            base_logger.send(meth)
          else
            base_logger.send(meth, *args)
          end
        end
      rescue NoMethodError => ex
        super
      end
    end

  private

    def current_settings
      {
        name: self.name,
        level: self.level,
        nested_count: self.nested_count
      }
    end

    LOGGER_LEVEL_TRANSLATION = {
      :disabled => -1,
      :debug => 0,
      :info => 1,
      :warn => 2,
      :error => 3,
      :fatal => 4
    }

    LOG4R_LEVEL_TRANSLATION = {
      :disabled => -1,
      :debug => 1,
      :info => 2,
      :warn => 3,
      :error => 4,
      :fatal => 5
    }

    def translate_level_in(lvl)
      if self.class.to_s =~ /Log4r/
        LOG4R_LEVEL_TRANSLATION[lvl.to_s.to_sym]
      else
        LOGGER_LEVEL_TRANSLATION[lvl.to_s.to_sym]
      end
    end

    def translate_level_out(lvl)
      if self.base_logger.class.to_s =~ /Log4r/
        LOG4R_LEVEL_TRANSLATION.key(lvl)
      else
        LOGGER_LEVEL_TRANSLATION.key(lvl)
      end
    end

  end
end