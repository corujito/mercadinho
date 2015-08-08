class Product < ActiveRecord::Base
  validates :full_name, :unity, presence: true

  enum unity: [ :caixa, :pacote, :kilo ]

end
