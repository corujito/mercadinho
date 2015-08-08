class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
