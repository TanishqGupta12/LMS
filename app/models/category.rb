class Category < ApplicationRecord
  has_many :sub_captions

  belongs_to :event
  has_many :courses
  
end
