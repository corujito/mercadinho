class Card < ActiveRecord::Base
  validates :password, :value, :discount, presence: true
end
