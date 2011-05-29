module <%= singular_name.camelize %>Decorator
  extend ActiveSupport::Concern

  # Access Rails' View Helpers by including any of these:
  
  # Just the content_tag method and friends:
  #   include ActionView::Helpers::TagHelper
  #
  # link_to and button_to:
  #   include ActionView::Helpers::UrlHelper
  #
  # pluralize, autolink, and cycle:
  #   include ActionView::Helpers::TextHelper
  #
  # Or the whole kitchen sink:
  #   include ActionView::Helpers
  
  module InstanceMethods
    # Example:
    # def formatted_created_at
    #   content_tag :span, created_at.strftime("%A")
    # end
  end  
end