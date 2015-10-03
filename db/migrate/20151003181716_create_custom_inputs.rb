class CreateCustomInputs < ActiveRecord::Migration
  def change
    create_table :custom_inputs do |t|
      t.decimal :amount, scale: 2, precision: 14
      t.string :description
      t.integer :input_type, default: 0

      t.timestamps
    end
  end
end