class Discount < ApplicationRecord
  belongs_to :event , optional: true
  has_many :tickets

  before_save :packe


  def packe

    if self.is_percentage == true
      self.is_percentage = true
    else
      self.is_percentage = false
    end
  end
  
end
