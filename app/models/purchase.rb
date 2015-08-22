class Purchase < ActiveRecord::Base
  belongs_to :vendor
  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  validates :discount, :items, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates_associated :items

  def total_price
    items.inject(0) { |sum, p| sum + p.unit_price * p.quantity }
  end

  def total_price_with_discount
    items.inject(0) { |sum, p| sum + p.unit_price * (1 - self.discount/100.to_f) * p.quantity }
  end

  def vendor_name
    vendor.try(:full_name)
  end

  def vendor_name=(name)
    self.vendor = Vendor.find_or_create_by(full_name: name) if name.present?
  end
end
