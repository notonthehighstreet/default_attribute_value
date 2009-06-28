class Product < ActiveRecord::Base
  default_attribute_value :vat_rate => proc { 17.5 }
  default_attribute_value :price => :default_price
  
  def default_price
    10
  end
end
