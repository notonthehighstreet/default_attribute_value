ActiveRecord::Schema.define :version => 0 do
  create_table :products, :force => true do |t|
    t.string :title
    t.float :vat_rate, :price
    t.boolean :active
  end
end
