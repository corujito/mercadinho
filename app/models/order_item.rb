class OrderItem < ActiveRecord::Base
  after_save :update_stock
  after_save :update_client_balance
  after_destroy :update_stock_destroy
  after_destroy :update_client_balance_destroy
  after_create :update_product_last_order_at

  belongs_to :product
  belongs_to :order

  usar_como_dinheiro :unit_price
  accepts_nested_attributes_for :product, :reject_if => :all_blank, :allow_destroy => false
  validates :product, :quantity, :unit_price, :product_name, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  def product_name
    product.try(:full_name)
  end

  def product_name=(name)
    self.product = Product.find_or_create_by(full_name: name) if name.present?
  end

  def quantity_formatted
    self.try(:quantity)
  end

  def quantity_formatted=(qtd)
    self.quantity = qtd.to_s.gsub('.', '').gsub(',', '.') if qtd.present?
  end

  def total_price
    self.unit_price * self.quantity
  end

  def total_price_custo_real_aproximado
    self.product.avg_price_with_discount * self.quantity
  end

  def estimate_profit
    self.total_price - self.total_price_custo_real_aproximado
  end

  def update_stock
    if self.product_id_changed? and self.product_id_was
      old_p = Product.find(self.product_id_was)
      new_p = self.product
      if self.quantity_changed?
        old_p.in_stock += self.quantity_was
        new_p.in_stock -= self.quantity
      else
        old_p.in_stock += self.quantity
        new_p.in_stock -= self.quantity
      end
      old_p.save
      new_p.save
    elsif self.quantity_changed?
      p = self.product
      if self.quantity_was
        p.in_stock -= self.quantity - self.quantity_was
      else
        p.in_stock -= self.quantity
      end
      p.save
    end
  end

  def update_stock_destroy
    p = self.product
    if p
      p.in_stock += self.quantity
      p.save
    else
      logger.warn "nao foi possivel executar update_stock_destroy no order_item"
    end
  end

  def update_client_balance
    if self.changed? and self.order and self.order.client
      c = self.order.client
      if self.quantity_was and self.unit_price_was
        c.balance -= (self.quantity * self.unit_price) - (self.quantity_was * self.unit_price_was)
      elsif self.quantity_was
        c.balance -= (self.quantity * self.unit_price) - (self.quantity_was * self.unit_price)
      elsif self.unit_price_was
        c.balance -= (self.quantity * self.unit_price) - (self.quantity * self.unit_price_was)
      else
        c.balance -= self.quantity * self.unit_price
      end
      c.save
    else
      logger.warn "nao foi possivel executar update_client_balance"
    end
  end

  def update_client_balance_destroy
    if self.order and self.order.client
      c = self.order.client
      c.balance += self.quantity * self.unit_price
      c.save
    else
      logger.warn "nao foi possivel executar update_client_balance_destroy"
    end
  end

  def update_product_last_order_at
    self.product.touch(:last_order_at) if self.product
  end
end
