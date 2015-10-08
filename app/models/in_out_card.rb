class InOutCard < ActiveRecord::Base
  belongs_to :card
  validates :card, presence: true

  paginates_per 20

  def card_name
    card.try(:full_name)
  end

  def card_identification
    card.try(:identification)
  end
end