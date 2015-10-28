class Card < ActiveRecord::Base
  validates :password, :full_name, :identification, presence: true
  paginates_per 20

  has_many :in_out_cards, :dependent => :destroy

  enum card_type: [ :outros, :visa, :master, :alelo, :sodexo ]
end