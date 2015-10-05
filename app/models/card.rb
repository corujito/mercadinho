class Card < ActiveRecord::Base
  validates :password, presence: true
  paginates_per 20

  has_many :in_out_cards
end