class CardsController < ApplicationController
  def index
    @event = Event.current_or_upcoming
  end
end
