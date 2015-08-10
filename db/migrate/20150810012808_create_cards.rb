class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :full_name
      t.string :identification
      t.string :password
      t.decimal :value
      t.decimal :discount

      t.timestamps
    end
  end
end
