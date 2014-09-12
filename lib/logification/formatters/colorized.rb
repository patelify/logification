require 'colorize'

module Logification
  module Formatters
    class Colorized
      def call(severity, datetime, progname, msg)
        formatted_msg = "#{datetime.strftime('%FT%T%:z')} #{severity.ljust(5)} - #{progname} - #{msg}"
        case severity
          when "DEBUG" then formatted_msg.green
          when "INFO" then formatted_msg.cyan
          when "WARN" then formatted_msg.yellow
          when "ERROR" then formatted_msg.red
          when "FATAL" then formatted_msg.magenta
        end + "\n"
      end
    end
  end
end