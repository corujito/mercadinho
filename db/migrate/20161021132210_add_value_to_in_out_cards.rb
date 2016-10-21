class AddValueToInOutCards < ActiveRecord::Migration
  def change
    add_column :in_out_cards, :value, :decimal, scale: 2, precision: 14
  end
end
