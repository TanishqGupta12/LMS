class Ticket < ApplicationRecord
  monetize :price_cents , numericality: { greater_than: 0 }

  belongs_to :event
  has_many :courses

end
