module Logification

  module Helpers

    module Wrapper

      def wrap(name, options={})
        settings = base_options.merge!(options)
        settings.merge!(name: name)
        self.send(settings[:wrap_level], start_message(settings))
        nested_logger = self.dup
        nested_logger.nested_count = self.nested_count+1 if settings[:nested_tabbing]
        block_response = yield(nested_logger) if block_given?
        self.send(settings[:wrap_level], end_message(settings))
        block_response
      end

    private

      def base_options
        {
          nested_tabbing: true,
          wrap_level: :info,
          start_time: Time.now
        }
      end

      def start_message(options={})
        options[:start_message] || "Starting '#{options[:name]}':"
      end

      def end_message(options={})
        options[:end_message] || summary_message(options)
      end

      def summary_message(options={})
        "Completed '#{options[:name]}' in #{(Time.now - options[:start_time]).round(3)}s"
      end

    end

  end

end