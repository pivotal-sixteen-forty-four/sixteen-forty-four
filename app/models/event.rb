class Event < ApplicationRecord
  def self.current_or_upcoming
    Event.where('ends_at >= ?', Time.current).order(:starts_at).first
  end
end
