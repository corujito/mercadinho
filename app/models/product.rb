class Product < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 20

  has_many :items
  has_many :order_items

  enum unity: [ :UN, :CX, :PCT, :KG, :LATA, :LT, :METRO, :PAR, :PEÇA ]

  def in_stock_formatted
    self.try(:in_stock)
  end

  def in_stock_formatted=(qtd)
    self.in_stock = qtd.to_s.gsub('.', '').gsub(',', '.') if qtd.present?
  end

  def avg_price_in_stock_with_discount
    if self.items.any? and self.in_stock > 0
      sum = 0
      sum_quantity = 0
      stock_aux = self.in_stock
      self.items.reverse.each do |item|
        quantity_aux = (item.quantity > stock_aux) ? stock_aux : item.quantity
        sum += item.unit_price * (1 - item.purchase.discount/100.to_f) * quantity_aux
        sum_quantity += quantity_aux
        stock_aux -= quantity_aux
        break if stock_aux == 0
      end
      return sum/sum_quantity
    end
    return 0
  end

  def avg_price_in_stock
    if self.items.any? and self.in_stock > 0
      sum = 0
      sum_quantity = 0
      stock_aux = self.in_stock
      self.items.reverse.each do |item|
        quantity_aux = (item.quantity > stock_aux) ? stock_aux : item.quantity
        sum += item.unit_price * quantity_aux
        sum_quantity += quantity_aux
        stock_aux -= quantity_aux
        break if stock_aux == 0
      end
      return sum/sum_quantity
    end
    return 0
  end

  def avg_price_with_discount(days_ago=7)
    if days_ago
      recent_items = self.items.includes(:purchase).where(created_at: days_ago.to_i.days.ago..Time.current)
      recent_items = [self.items.includes(:purchase).last] if recent_items.empty?
    else
      recent_items = self.items.includes(:purchase)
    end
    # recent_items = days_ago ? self.items.where(created_at: days_ago.to_i.days.ago..Time.current) : self.items
    if recent_items.any?
      sum = 0
      sum_quantity = 0
      recent_items.each do |item|
        sum += item.unit_price * (1 - item.purchase.discount/100.to_f) * item.quantity
        sum_quantity += item.quantity
      end
      return sum/sum_quantity
    end
    return 0
  end

  def avg_price
    if self.items.any?
      sum = 0
      sum_quantity = 0
      self.items.each do |item|
        sum += item.unit_price * item.quantity
        sum_quantity += item.quantity
      end
      return sum/sum_quantity
    end
    return 0
  end
end
