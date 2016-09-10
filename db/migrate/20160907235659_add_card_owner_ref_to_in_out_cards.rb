class AddCardOwnerRefToInOutCards < ActiveRecord::Migration
  def change
    add_reference :in_out_cards, :card_owner, index: true
  end

  def migrate(direction)
    super
    # Set default card owner
    if direction == :up
      InOutCard.where(card_owner_id: nil).update_all(card_owner_id: CardOwner.first.id)
    end
  end
end
