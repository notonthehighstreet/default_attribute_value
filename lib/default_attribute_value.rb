module DefaultAttributeValue
  def self.included(base)
    base.class_eval do
      class_attribute :_default_attribute_values
      self._default_attribute_values = {}
      
      extend ClassMethods
      include InstanceMethods
    end
  end
  
  module ClassMethods
    def default_attribute_value(default_attributes)
      store_written_default = default_attributes.delete(:store_written_default)
      
      self._default_attribute_values = _default_attribute_values.merge(default_attributes.stringify_keys)
      
      default_attributes.each do |attribute, callback|
        class_eval <<-END
          def #{attribute}
            value = read_attribute("#{attribute}")
            
            if value.present? or value == false
              value
            else
              default_attribute_value_result("#{attribute}")
            end
          end
        END
        
        unless store_written_default
          class_eval <<-END
            def #{attribute}=(value)
              write_attribute("#{attribute}", value)
            
              if self["#{attribute}"] == default_attribute_value_result("#{attribute}")
                write_attribute("#{attribute}", nil)
              end
            end
          END
        end
      end
    end
  end
  
  module InstanceMethods
   private
    def default_attribute_value_result(attribute)
      callback = _default_attribute_values[attribute]
      
      case callback
      when Symbol
        send(callback)
      when Proc
        callback.call(self)
      end
    end
  end
end

class ActiveRecord::Base
  include DefaultAttributeValue
end
