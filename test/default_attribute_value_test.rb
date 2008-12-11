require 'test_helper'
require "default_attribute_value"

class Product
  include DefaultAttributeValue
  
  def initialize(attributes)
    @attributes = attributes
  end
  
  def read_attribute(name)
    @attributes[name]
  end
  
  def title
    read_attribute(:title)
  end
  
  def vat_rate
    read_attribute(:vat_rate)
  end
  
  def vat_rate?
    read_attribute(:vat_rate).present?
  end
  
  default_attribute_value :vat_rate => proc { 17.5 }
end

class DefaultAttributeValueTest < ActiveSupport::TestCase
  test "normal blank attribute should be returned unchanged" do
    @product = Product.new(:title => "")
    assert_equal "", @product.title
  end
  
  test "should return default when value blank" do
    @product = Product.new(:title => "")
    assert_equal 17.5, @product.vat_rate
  end
  
  test "should return false when set on attribute" do
    assert_equal false, Product.new(:vat_rate => false).vat_rate
  end
end
