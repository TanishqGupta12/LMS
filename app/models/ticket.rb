class Ticket < ApplicationRecord
  monetize :price_cents, numericality: { greater_than: 0 }, with_model_currency: :currency

  has_many :courses
  belongs_to :user , optional: true
  belongs_to :event

end
