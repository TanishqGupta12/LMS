class Category < ApplicationRecord

  belongs_to :event
  has_many :courses
  has_many :blogs
  
end
