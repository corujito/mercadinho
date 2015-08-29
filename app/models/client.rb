class Client < ActiveRecord::Base
  validates :full_name, presence: true
  paginates_per 20

  usar_como_dinheiro :balance

  has_many :orders
end
