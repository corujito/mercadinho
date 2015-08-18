class Card < ActiveRecord::Base
  validates :password, presence: true
  paginates_per 20
end
