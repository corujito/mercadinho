class Product < ActiveRecord::Base
  validates :full_name, presence: true
  paginates_per 20

  enum unity: [ :UN, :CX, :PCT, :KG, :LATA, :LT, :METRO, :PAR, :PEÇA ]

end
