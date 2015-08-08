class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :full_name
      t.integer :unity

      t.timestamps
    end
  end
end
