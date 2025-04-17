class FormSectionField < ApplicationRecord
  belongs_to :form
  belongs_to :form_section
  has_many :form_field_choices

  scope :list_of_fields, ->(event_id) { 
    where("form_section_fields.is_active = ? AND form_section_fields.form_id IN (SELECT id FROM forms WHERE event_id = ? AND is_active = ?)",true, event_id, true)
    # .order(:sequence) 
  }

  def title
    self.caption
  end
end