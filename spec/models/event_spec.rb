require 'rails_helper'

RSpec.describe Event, :type => :model do
  before do
    Event.delete_all
  end

  describe '.current_or_upcoming' do
    context 'with past, future, and current events' do
      it 'returns the current and future events' do
        now = Time.current
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)
        Event.create(name: 'future event', starts_at: now.advance(hours: 1), ends_at: now.advance(hours: 3))
        Event.create(name: 'current event', starts_at: 1.hour.ago, ends_at: now.advance(hours: 1))

        event_names = Event.current_or_upcoming.collect { |event| event.name }
        expect(event_names).to contain_exactly('current event', 'future event')
      end
    end

    context 'when no current event' do
      it 'returns a future event' do
        now = Time.current
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)
        Event.create(name: 'future event', starts_at: now.advance(hours: 1), ends_at: now.advance(hours: 3))

        event_names = Event.current_or_upcoming.collect { |event| event.name }
        expect(event_names).to contain_exactly('future event')
      end
    end

    context 'when only past events' do
      it 'returns nil' do
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)

        expect(Event.current_or_upcoming).to be_empty
      end
    end
  end
end
