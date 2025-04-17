class FormSection < ApplicationRecord
  belongs_to :form

  def title
    self.caption
  end
  
end