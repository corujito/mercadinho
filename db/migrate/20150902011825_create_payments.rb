class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :client, index: true
      t.decimal :amount, scale: 2, precision: 14

      t.timestamps
    end
  end
end
