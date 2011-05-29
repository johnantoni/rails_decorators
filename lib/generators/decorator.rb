require 'rails/generators/base'

module Decorator
  module Generators
    class Base < Rails::Generators::Base #:nodoc:
      def self.source_root
        @_decorator_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'decorator', generator_name, 'templates'))
      end

      def self.banner
        "rails generate decorator:#{generator_name} #{self.arguments.map{ |a| a.usage }.join(' ')} [options]"
      end
    end
  end
end