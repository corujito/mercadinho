class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :purchase

  # has_many :items
  accepts_nested_attributes_for :product, :reject_if => :all_blank, :allow_destroy => false
  validates :product, :quantity, :unit_price, :product_name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  #
  def product_name
    product.try(:full_name)
  end

  def product_name=(name)
    self.product = Product.find_or_create_by(full_name: name) if name.present?
  end

  def unit_price_with_discount
    self.unit_price * (1 - self.purchase.discount/100.to_f)
  end
end
