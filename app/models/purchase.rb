class Purchase < ActiveRecord::Base
  belongs_to :vendor
  has_many :items
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  validates :discount, :items, presence: true

  def vendor_name
    vendor.try(:full_name)
  end

  def vendor_name=(name)
    self.vendor = Vendor.find_or_create_by(full_name: name) if name.present?
  end
end
