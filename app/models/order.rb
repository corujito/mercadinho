class Order < ActiveRecord::Base
  belongs_to :client
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :reject_if => :all_blank, :allow_destroy => true
  validates :order_items, presence: true
  validates :client, presence: true
  validates_associated :order_items
  validate :client_id_not_changed

  enum status: [ :pending, :paid ]

  def total_price
    order_items.inject(0) { |sum, p| sum + p.unit_price * p.quantity }
  end

  def total_price_custo_real_aproximado(time=Time.current)
    order_items.inject(0) do |sum, p|
      if p.product
        sum + p.product.avg_price_with_discount(time) * p.quantity
      else
        sum
      end
    end
  end

  def estimate_profit
    self.total_price - self.total_price_custo_real_aproximado
  end

  def estimate_profit_per_product(time=Time.current)
    order_items.inject(0) do |sum, p|
      if p.product and p.product.avg_price_with_discount(time) > 0
        sum + (p.unit_price * p.quantity) - (p.product.avg_price_with_discount(time) * p.quantity)
      else
        sum
      end
    end
  end

  # def estimate_profit_per_product
  #   order_items.inject(0) do |sum, p|
  #     if p.product and p.product.in_stock > 0
  #       sum + (p.unit_price * p.quantity) - (p.product.avg_price_in_stock_with_discount * p.quantity)
  #     else
  #       sum
  #     end
  #   end
  # end

  def client_name
    client.try(:full_name)
  end

  def client_name=(name)
    self.client = Client.find_or_create_by(full_name: name) if name.present?
  end

  def self.get_orders(start_date, end_date)
    Order.where(:created_at => start_date..end_date)
  end

  def self.purge(months_ago)
    puts "Purging orders..."
    puts "Total orders: #{Order.count}"
    puts "Total orderitems: #{OrderItem.count}"
    OrderItem.skip_callback(:destroy, :after, :update_stock_destroy)
    OrderItem.skip_callback(:destroy, :after, :update_client_balance_destroy)
    Order.paid.where("created_at < ?", months_ago.to_i.months.ago).destroy_all
    puts "Total orders left: #{Order.count}"
    puts "Total orderitems left: #{OrderItem.count}"
  end

  private

  def client_id_not_changed
    if client_id_changed? and self.persisted?
      errors.add(:client_id, "Não é permitido a alteração do cliente!")
    end
  end
end
