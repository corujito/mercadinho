class Payment < ActiveRecord::Base
  after_save :update_client_balance
  after_destroy :update_client_balance_destroy

  belongs_to :client
  validates :amount, :client, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  usar_como_dinheiro :amount

  def client_name
    client.try(:full_name)
  end

  def client_name=(name)
    self.client = Client.find_or_create_by(full_name: name) if name.present?
  end

  def update_client_balance
    if self.changed?
      c = self.client
      if self.amount_was
        c.balance += self.amount - self.amount_was
      else
        c.balance += self.amount
      end
      c.save
    end
  end

  def update_client_balance_destroy
    c = self.client
    if c
      c.balance -= self.amount
      c.save
    else
      logger.warn "nao foi possivel executar update_client_balance_destroy"
    end
  end

  def self.purge(months_ago)
    puts "Purging payments..."
    puts "Total payments: #{Payment.count}"
    Payment.where("created_at < ?", months_ago.to_i.months.ago).delete_all
    puts "Total payments left: #{Payment.count}"
  end
end
