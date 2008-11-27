module DefaultAttributeValue
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end
  
  module ClassMethods
    def default_attribute_value(options)
      options.each do |attribute, block|
        define_method attribute do
          value = read_attribute(attribute)
          value.present? ? value : block.call(self)
        end
      end
    end
  end
end
