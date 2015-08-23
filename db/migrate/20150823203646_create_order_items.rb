class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.integer :unit_price, scale: 2, precision: 14
      t.references :product, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end
