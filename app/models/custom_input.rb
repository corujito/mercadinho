class CustomInput < ActiveRecord::Base
  validates :description, :input_type, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  usar_como_dinheiro :amount
  paginates_per 20

  enum input_type: [ :despesa, :ganho ]
end
