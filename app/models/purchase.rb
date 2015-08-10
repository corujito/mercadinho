class Purchase < ActiveRecord::Base
  belongs_to :vendor
  has_many :items
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  validates :vendor, presence: true
end
