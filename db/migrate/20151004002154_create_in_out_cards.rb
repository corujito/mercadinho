class CreateInOutCards < ActiveRecord::Migration
  def change
    create_table :in_out_cards do |t|
      t.references :card, index: true

      t.timestamps
    end
  end
end
