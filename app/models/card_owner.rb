class CardOwner < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :in_out_type, message: "deve ser unico por tipo" }

  enum in_out_type: [ :in, :out ]

  has_many :in_out_cards, :dependent => :nullify
end
