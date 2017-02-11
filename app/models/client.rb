class Client < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 50

  usar_como_dinheiro :balance

  has_many :orders
  has_many :payments
  has_many :order_items, through: :orders

  def estimate_profit(time=Time.current)
    self.orders.inject(0) { |sum, o| sum + o.estimate_profit_per_product(time) }
  end

  def total_paid
    self.payments.inject(0) {|sum, pp| sum + pp.amount}
  end

  def self.pending_payments
    clients = Client.where("balance < ?", 0)
    if clients.any?
      sum = clients.inject(0){|sum,e| sum += e.balance }
    else
      return 0
    end
  end
end
