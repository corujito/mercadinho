class AddTypeToCardowners < ActiveRecord::Migration
  def change
    add_column :card_owners, :in_out_type, :integer, default: 0
  end
end
