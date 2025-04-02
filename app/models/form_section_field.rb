class FormSectionField < ApplicationRecord
  belongs_to :form

  scope :list_of_fields, ->(event_id) { 
    where("form_section_fields.is_active = ? AND form_section_fields.id IN (SELECT form_id FROM forms WHERE event_id = ? AND is_active = ?)",true, event_id, true)
    .order(:sequence) 
  }

end