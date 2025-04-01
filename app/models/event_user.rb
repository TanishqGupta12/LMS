class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  before_save :set_event

  def set_event
    debugger
    self.user.current_event_id = self.events.try(:id)
  end

end
