class Vendor < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 50
end
