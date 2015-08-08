class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :address
      t.boolean :active

      t.timestamps
    end
  end
end
