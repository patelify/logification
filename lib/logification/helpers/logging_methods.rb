module Logification

  module Helpers

    module LoggingMethods

      TAB = "    "

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

      def is_nested?
        not nested_count.nil? and nested_count > 0
      end

    private

      def log_message(type, msg, color)
        msg = messagify(msg)
        base_logger.send(type, msg.to_s.send(color))
        msg
      end

      def messagify(msg)
        tabify(msg)
      end

      def tabify(msg)
        return msg unless is_nested?
        tab = TAB * nested_count # tab = 4 spaces
        tab + msg
      end

    end

  end

end