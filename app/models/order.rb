class Order < ActiveRecord::Base
  belongs_to :client
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :reject_if => :all_blank, :allow_destroy => true
  validates :order_items, presence: true
  validates :client, presence: true
  validates_associated :order_items
  validate :client_id_not_changed

  enum status: [ :pending, :paid ]

  def total_price
    order_items.inject(0) { |sum, p| sum + p.unit_price * p.quantity }
  end

  def client_name
    client.try(:full_name)
  end

  def client_name=(name)
    self.client = Client.find_or_create_by(full_name: name) if name.present?
  end

  private

  def client_id_not_changed
    if client_id_changed? and self.persisted?
      errors.add(:client_id, "Não é permitido a alteração do cliente!")
    end
  end
end
