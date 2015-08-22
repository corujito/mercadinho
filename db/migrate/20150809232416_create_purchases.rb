class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :vendor, index: true
      t.decimal :discount, scale: 2, precision: 5

      t.timestamps
    end
  end
end
