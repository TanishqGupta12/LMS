class Form < ApplicationRecord
  belongs_to :event
  belongs_to :role

  has_many :form_section_fields
  has_many :form_sections
   
  def name
    self.caption
  end
end
