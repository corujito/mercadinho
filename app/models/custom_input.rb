class CustomInput < ActiveRecord::Base
  validates :description, :input_type, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  usar_como_dinheiro :amount
  paginates_per 50

  enum input_type: [ :despesa, :ganho ]

  def self.purge(months_ago)
    puts "Total custominputs: #{CustomInput.count}"
    CustomInput.where("created_at < ?", months_ago.to_i.months.ago).delete_all
    puts "Total custominputs left: #{CustomInput.count}"
  end
end
