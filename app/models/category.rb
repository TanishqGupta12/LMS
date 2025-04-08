class Category < ApplicationRecord

  belongs_to :event
  has_many :courses
  has_many :blogs
  belongs_to :quiz_topic
  
end
