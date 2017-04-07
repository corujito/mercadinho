class CreateCardOwners < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default card owner
    if direction == :up
      #CardOwner.create!(name: 'responsável1')
      #CardOwner.create!(name: 'responsável2')
      #CardOwner.create!(name: 'responsável3')
    end
  end

  def change
    create_table :card_owners do |t|
      t.string :name

      t.timestamps
    end
  end
end
