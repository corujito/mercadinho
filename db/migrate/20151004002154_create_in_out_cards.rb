class CreateInOutCards < ActiveRecord::Migration
  def change
    create_table :in_out_cards do |t|
      t.references :card, index: true
      t.integer :inout_type, default: 0

      t.timestamps
    end
  end
end
