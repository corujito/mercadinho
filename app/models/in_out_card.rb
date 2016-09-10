class InOutCard < ActiveRecord::Base
  belongs_to :card
  validates :card, presence: true

  belongs_to :card_owner

  accepts_nested_attributes_for :card

  paginates_per 20

  def card_name
    card.try(:full_name)
  end

  def card_identification
    card.try(:identification)
  end

  def self.purge(months_ago)
    puts "Total inoutcards: #{InOutCard.count}"
    InOutCard.where("created_at < ?", months_ago.to_i.months.ago).delete_all
    puts "Total inoutcards left: #{InOutCard.count}"
  end
end