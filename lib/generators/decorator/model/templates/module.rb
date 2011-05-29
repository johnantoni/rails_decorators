module <%= singular_name.camelize %>Decorator
  extend ActiveSupport::Concern

  # Uncomment this line to have access to the Rails view helpers like link_to and content_tag:
  # include ActionView::Helpers
  
  module InstanceMethods
    # Add your instance methods here
    
    # Example:
    # def formatted_created_at
    #   content_tag :span, created_at.strftime("%A")
    # end
  end  
end