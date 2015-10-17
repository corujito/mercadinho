class AddLastOrderDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :last_order_at, :datetime
  end
end
