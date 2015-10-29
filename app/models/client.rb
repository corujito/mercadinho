class Client < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 20

  usar_como_dinheiro :balance

  has_many :orders
  has_many :payments
  has_many :order_items, through: :orders

  def estimate_profit
    self.orders.inject(0) { |sum, o| sum + o.estimate_profit_per_product }
  end
end
