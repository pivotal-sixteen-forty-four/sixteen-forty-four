require 'rails_helper'

RSpec.describe Event, :type => :model do
  before do
    Event.delete_all
  end

  describe '.current_or_upcoming' do
    context 'with past, future, and current events' do
      it 'returns the current event' do
        now = Time.current
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)
        Event.create(name: 'future event', starts_at: now.advance(hours: 1), ends_at: now.advance(hours: 3))
        Event.create(name: 'current event', starts_at: 1.hour.ago, ends_at: now.advance(hours: 1))

        expect(Event.current_or_upcoming.name).to eq('current event')
      end
    end

    context 'when no current event' do
      it 'returns a future event' do
        now = Time.current
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)
        Event.create(name: 'future event', starts_at: now.advance(hours: 1), ends_at: now.advance(hours: 3))

        expect(Event.current_or_upcoming.name).to eq('future event')
      end
    end

    context 'when only past events' do
      it 'returns nil' do
        Event.create(name: 'past event', starts_at: 4.hours.ago, ends_at: 1.hour.ago)

        expect(Event.current_or_upcoming).to be_nil
      end
    end
  end
end
