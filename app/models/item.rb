class Item < ActiveRecord::Base
  after_save :update_stock
  after_destroy :update_stock_destroy

  belongs_to :product
  belongs_to :purchase

  usar_como_dinheiro :unit_price
  # usar_como_dinheiro :quantity
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

  def unit_price_with_discount
    self.unit_price * (1 - self.purchase.discount/100.to_f)
  end

  def update_stock
    if self.product_id_changed? and self.product_id_was
      old_p = Product.find(self.product_id_was)
      new_p = self.product
      if self.quantity_changed?
        old_p.in_stock -= self.quantity_was
        new_p.in_stock += self.quantity
      else
        old_p.in_stock -= self.quantity
        new_p.in_stock += self.quantity
      end
      old_p.save
      new_p.save
    elsif self.quantity_changed?
      p = self.product
      if self.quantity_was
        p.in_stock += self.quantity - self.quantity_was
      else
        p.in_stock += self.quantity
      end
      p.save
    end
  end

  def update_stock_destroy
    p = self.product
    if p
      p.in_stock -= self.quantity
      p.save
    else
      logger.warn "nao foi possivel executar update_stock_destroy no item"
    end
  end
end
