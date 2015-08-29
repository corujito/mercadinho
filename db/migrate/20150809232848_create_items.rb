class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :quantity
      t.decimal :unit_price, scale: 2, precision: 14
      t.references :product, index: true
      t.references :purchase, index: true

      t.timestamps
    end
  end
end
