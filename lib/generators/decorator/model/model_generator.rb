module Decorator
  class ModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def build_module
      template 'module.rb', "app/decorators/#{singular_name}_decorator.rb"
    end
  end
end