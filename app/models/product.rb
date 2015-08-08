class Product < ActiveRecord::Base
  validates :full_name, :unity, presence: true
end
