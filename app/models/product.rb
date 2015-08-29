class Product < ActiveRecord::Base
  validates :full_name, presence: true
  validates :full_name, uniqueness: { case_sensitive: false }
  paginates_per 20

  has_many :order_items

  enum unity: [ :UN, :CX, :PCT, :KG, :LATA, :LT, :METRO, :PAR, :PEÇA ]

end
