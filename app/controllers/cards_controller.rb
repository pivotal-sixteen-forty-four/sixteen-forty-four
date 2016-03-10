class CardsController < ApplicationController
  def index
    events = Event.current_or_upcoming
    @event = events.first
    @events = events.limit(6).group_by {|e| e.starts_at.to_date }
    render layout: false
  end
end
