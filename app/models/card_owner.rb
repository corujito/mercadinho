class CardOwner < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :in_out_cards
end
