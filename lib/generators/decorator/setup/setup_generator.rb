module Decorator
  class SetupGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
  
    def create_directory
      empty_directory "app/decorators"
    end  
  
    # def build_initializer
    #   initializer("load_decorators.rb") do
    #     "RailsDecorators::Loader.load"
    #   end
    # end
  end
end