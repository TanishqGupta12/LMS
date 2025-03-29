class Event < ApplicationRecord

  has_many :categories
  has_many :contacts
  has_many :banners
end
