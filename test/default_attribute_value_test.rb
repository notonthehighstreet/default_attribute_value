require File.dirname(__FILE__) + '/test_helper'

class DefaultAttributeValueTest < ActiveSupport::TestCase
  test "normal blank attribute should be returned unchanged" do
    assert_equal "", Product.create!(:title => "").title
  end
  
  test "should return default from block when value blank" do
    assert_equal 17.5, Product.create!(:title => "").vat_rate
  end
  
  test "should return default from method when value blank" do
    assert_equal 10, Product.create!(:price => "").price
  end
  
  test "should return false when set on attribute" do
    assert_equal false, Product.create!(:active => false).active
  end
  
  test "should ignore the setting of an attribute to its default value" do
    product = Product.create!(:vat_rate => 17.5)
    
    assert_equal 17.5, product.vat_rate
    assert_nil product[:vat_rate]
  end
  
  test "should save attribute values when not set to the default" do
    product = Product.create!(:vat_rate => 12)
    
    assert_equal 12, product.vat_rate
    assert_equal 12, product[:vat_rate]
  end
end
