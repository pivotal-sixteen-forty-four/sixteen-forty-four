class CardsController < ApplicationController
  layout 'cards'
  def index
    events = Event.current_or_upcoming
    @event = events.first
    @todays_events = events.where(starts_at: Date.today.beginning_of_day..Date.today.end_of_day).to_a
    @todays_events << @event if @todays_events.none? && @event
    @events = events.limit(6).group_by {|e| e.starts_at.to_date }
    @companies = Company.all
  end
end
