class Form < ApplicationRecord
  belongs_to :event
  belongs_to :role

  has_many :form_section_fields

  def name
    self.caption
  end
end
