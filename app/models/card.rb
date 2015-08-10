class Card < ActiveRecord::Base
  validates :password, :value, :discount, presence: true
  paginates_per 20
end
