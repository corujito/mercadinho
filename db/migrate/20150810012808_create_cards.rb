class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :full_name
      t.string :identification
      t.string :password
      t.string :cpf
      t.string :email
      t.string :phone
      t.integer :card_type, default: 0

      t.timestamps
    end
  end
end
