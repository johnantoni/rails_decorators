require 'generators/decorator'

module Decorator
  module Generators
    class SetupGenerator < Base
      def create_setup
        directory "app/decorators"
        copy_file "load_decorators.rb", "config/initializers/load_decorators.rb"
      end
    end
  end
end