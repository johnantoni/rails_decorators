class <%= singular_name.camelize %>Decorator
  # Access Rails' View Helpers by including any of these:
  #
  #   Just the content_tag method and friends:
  #     include ActionView::Helpers::TagHelper
  #   link_to and button_to:
  #     include ActionView::Helpers::UrlHelper
  #   pluralize, autolink, and cycle:
  #     include ActionView::Helpers::TextHelper
  #   Or the whole kitchen sink:
  #     include ActionView::Helpers
  #
  # Define presentation-related instance methods
  #   Example:
  #   def formatted_created_at
  #     content_tag :span, created_at.strftime("%A")
  #   end
  
  # Dynamically generate methods to delegate to
  # to the subject object without method_missing
  # Stolen with love from Jay Fields (http://blog.jayfields.com/2008/02/ruby-replace-methodmissing-with-dynamic.html)
  def initialize(subject)
    subject.public_methods(false).each do |method|
      (class << self; self; end).class_eval do
        define_method method do |*args|
          subject.send method, *args
        end
      end
    end  
  end
end