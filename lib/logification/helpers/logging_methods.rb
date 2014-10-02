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

    private

      def is_disabled?
        self.level == :disabled
      end

      def log_message(type, msg, color)
        return msg if msg.nil?
        msg = messagify(msg)
        return msg if is_disabled?
        self.base_logger.send(type, msg.to_s.send(color))
        msg
      end

      def messagify(msg)
        if msg.is_a?(Exception)
          exception = msg
          error_message = "Caught #{exception.class}: #{exception.message}"
          msg = [error_message, exception.backtrace].join("\n")
        end
        tabify(msg)
      end

      def tabify(msg)
        return msg unless is_nested?
        tab = TAB * self.nested_count # tab = 4 spaces
        tab + msg
      end

      def is_nested?
        not self.nested_count.nil? and self.nested_count > 0
      end

    end

  end

end