module DefaultAttributeValue
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end
  
  module ClassMethods
    def default_attribute_value(options)
      options.each do |attribute, callback|
        define_method attribute do
          value = read_attribute(attribute)
          
          if value.present? or value == false
            value
          else
            case callback
            when Symbol
              send(callback)
            when Proc
              callback.call(self)
            end
          end
        end
      end
    end
  end
end
