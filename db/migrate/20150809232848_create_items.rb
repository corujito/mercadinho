class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :discount
      t.references :product, index: true
      t.references :purchase, index: true

      t.timestamps
    end
  end
end
