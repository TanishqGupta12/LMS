class FormSection < ApplicationRecord
  belongs_to :form
  has_many :form_section_fields
  def title
    self.caption
  end
  
end