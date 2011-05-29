ActionController::Dispatcher.to_prepare do
  models = Dir.glob(File.join(Rails.root, '/app/models/*.rb')).map do |file|
    file.match(/(\w*).rb/)[1].split('_').map do |class_part|
      class_part.capitalize
    end.join('')
  end
  
  models.each do |model|
    begin
      decorator = (model + "Decorator").constantize
      model.constantize.send :include, decorator
    rescue NameError
      # No Decorator Exists
    end
  end
end