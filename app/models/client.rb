class Client < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 20

  usar_como_dinheiro :balance

  has_many :orders
  has_many :payments
end
