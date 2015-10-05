class InOutCard < ActiveRecord::Base
  belongs_to :card
  validates :card, :inout_type, presence: true

  paginates_per 20

  enum inout_type: [ :saida, :entrada ]

  def card_name
    card.try(:full_name)
  end

  def card_identification
    card.try(:identification)
  end
end