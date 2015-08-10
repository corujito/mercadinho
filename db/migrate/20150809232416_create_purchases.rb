class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :vendor, index: true
      t.integer :total_price

      t.timestamps
    end
  end
end
