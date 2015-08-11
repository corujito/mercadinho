class Product < ActiveRecord::Base
  validates :full_name, :unity, presence: true
  paginates_per 20

  enum unity: [ :CX, :PCT, :KG, :LATA, :LT, :METRO, :PAR, :PEÇA, :UN ]

end
