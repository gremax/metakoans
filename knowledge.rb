class Module
  def attribute(data, &block)
    if data.is_a?(Hash)
      attribute = data.keys.first
      default   = data[attribute]
    else 
      attribute = data
      default   = nil
    end

    var = :"@#{attribute}"

    define_method attribute.to_sym do
      if instance_variable_defined?(var)
        instance_variable_get(var)
      elsif block_given?
        instance_eval(&block)
      else
        default
      end
    end

    define_method "#{attribute}=".to_sym do |value|
      instance_variable_set(var, value)
    end

    define_method "#{attribute}?".to_sym do
      send(attribute.to_sym)
    end
  end
end