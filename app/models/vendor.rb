class Vendor < ActiveRecord::Base
  validates :full_name, presence: true
  paginates_per 20
end
