require 'rails_helper'

describe 'cards' do
  let(:flip_timeout) { AcceptanceHelpers::DEFAULT_FLIP_TIME }
  around do |example|
    visit '/'
    with_flip_timeout(flip_timeout) do
      page.driver.browser.manage.window.resize_to(1920, 1160)
      example.run
    end
  end

  it 'shows instructions for knoll' do
    within '.card', text: 'Knoll' do
      expect(page).to have_content(I18n.t('companies.knoll.title'))
      expect(page).to have_content(I18n.t('companies.knoll.floor'))
      expect(page).to have_content(I18n.t('companies.knoll.suite'))
      expect(page).to have_content(I18n.t('companies.knoll.instructions'))
      expect(page).to_not have_css('.card-flipper--flipped')

      page.first('div', text: 'Knoll').click

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to have_content('knoll.com')

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to_not have_css('.card-flipper--flipped')
    end
  end

  it 'shows instructions for pivotal' do
    within '.card', text: 'Pivotal' do
      expect(page).to have_content(I18n.t('companies.pivotal.title'))
      expect(page).to have_content(I18n.t('companies.pivotal.floor'))
      expect(page).to have_content(I18n.t('companies.pivotal.suite'))
      expect(page).to have_content(I18n.t('companies.pivotal.instructions'))
      expect(page).to_not have_css('.card-flipper--flipped')

      page.first('div', text: 'Pivotal').click

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to have_content('Brian Rose')

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to_not have_css('.card-flipper--flipped')
    end
  end

  it 'shows instructions for galvanize' do
    within '.card', text: 'Galvanize' do
      expect(page).to have_content(I18n.t('companies.galvanize.title'))
      expect(page).to have_content(I18n.t('companies.galvanize.floor'))
      expect(page).to have_content(I18n.t('companies.galvanize.suite'))
      expect(page).to have_content(I18n.t('companies.galvanize.instructions'))
      expect(page).to_not have_css('.card-flipper--flipped')

      page.first('div', text: 'Galvanize').click

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to have_content('galvanize.it')

      expect(page).to have_css('.card-flipper--flipped')
      expect(page).to_not have_css('.card-flipper--flipped')
    end
  end

  context 'when there is no upcoming event' do
    it 'shows generic building information' do
      start_at = Time.current.advance(hours: -3)
      ends_at = start_at.advance(hours: -2)
      Event.create(name: 'Denver.rb', floor: '2', suite: '200', description: 'Denver ruby meetup', starts_at: start_at, ends_at: ends_at)

      visit '/'

      within '.card', text: 'Welcome' do
        expect(page).to have_content(I18n.t('building.welcome'))
        expect(page).to have_content(I18n.t('building.name'))
        expect(page).to have_content(I18n.t('building.description'))
      end
    end
  end

  context 'when there is an event' do
    it 'shows the event information' do
      start_at = Time.current.next_week(:tuesday).advance(hours: 18)
      ends_at = start_at.advance(hours: 3)
      Event.create!(name: 'Denver.rb', floor: '2', suite: '200', description: 'Denver ruby meetup', starts_at: start_at, ends_at: ends_at, image_url: '//s3.amazonaws.com/sixteen-forty-four/images/61c68605-2e38-4057-bc87-c64aa7377ac1/ruby.jpg')

      visit '/'

      within '.card', text: 'Denver.rb' do
        expect(page).to have_content('FL 2')
        expect(page).to have_content('Suite 200')
        expect(page).to have_content('Denver ruby meetup')
        expect(page).to have_content(start_at.strftime('%A, %B %e')) # Tuesday, March 11
        expect(page).to have_content('6:00 PM')
        expect(page).to have_content('9:00 PM')
      end
    end
  end

  context 'when there are multiple upcoming events' do
    it 'shows six upcoming events on the back' do
      start_at = Time.current.next_week(:tuesday).advance(hours: 18)
      ends_at = start_at.advance(hours: 3)
      Event.create!(name: 'Denver.rb', floor: '2', suite: '200', description: 'Denver ruby meetup', starts_at: start_at, ends_at: ends_at)
      Event.create!(name: 'denver.cc', floor: '2', suite: '200', description: 'Denver C++ meetup', starts_at: start_at.advance(days: 1), ends_at: ends_at.advance(days: 1))
      Event.create!(name: 'denver.py', floor: '2', suite: '200', description: 'Denver Python meetup', starts_at: start_at.advance(days: 2), ends_at: ends_at.advance(days: 2))
      Event.create!(name: 'denver.go', floor: '2', suite: '200', description: 'Denver GoLang meetup', starts_at: start_at.advance(days: 3), ends_at: ends_at.advance(days: 3))
      Event.create!(name: 'denver.rs', floor: '2', suite: '200', description: 'Denver Rust meetup', starts_at: start_at.advance(days: 4), ends_at: ends_at.advance(days: 4))
      Event.create!(name: 'denver.js', floor: '2', suite: '200', description: 'Denver JavaScript meetup', starts_at: start_at.advance(days: 5), ends_at: ends_at.advance(days: 5))
      Event.create!(name: 'denver.ts', floor: '2', suite: '200', description: 'Denver TypeScript meetup', starts_at: start_at.advance(days: 6), ends_at: ends_at.advance(days: 6))

      visit '/'

      within_event_card do
        page.first('div', text: 'Denver.rb').click
      end

      within_event_card(:back) do
        expect(page).to have_content(start_at.strftime('%A, %B %e').upcase)
        expect(page).to have_content('Denver.rb')

        expect(page).to have_content(start_at.advance(days: 1).strftime('%A, %B %e').upcase)
        expect(page).to have_content('denver.cc')

        expect(page).to have_content(start_at.advance(days: 2).strftime('%A, %B %e').upcase)
        expect(page).to have_content('denver.py')

        expect(page).to have_content(start_at.advance(days: 3).strftime('%A, %B %e').upcase)
        expect(page).to have_content('denver.go')

        expect(page).to have_content(start_at.advance(days: 4).strftime('%A, %B %e').upcase)
        expect(page).to have_content('denver.rs')

        expect(page).to have_content(start_at.advance(days: 5).strftime('%A, %B %e').upcase)
        expect(page).to have_content('denver.js')

        expect(page).to_not have_content(start_at.advance(days: 6).strftime('%A, %B %e').upcase)
        expect(page).to_not have_content('denver.ts')
      end
    end
  end

  context 'when there are multiple upcoming events TODAY' do
    it 'rotates through them on the front' do
      start_at = Date.today.middle_of_day
      ends_at = start_at.advance(days: 0.75)
      Event.create!(name: 'Denver.rb', floor: '2', suite: '200', description: 'Denver Ruby meetup', starts_at: start_at, ends_at: ends_at)
      Event.create!(name: 'Denver.go', floor: '2', suite: '200', description: 'Denver GoLang meetup', starts_at: start_at.advance(minutes: 20), ends_at: ends_at.advance(minutes: 20))

      visit '/'

      within_event_card(:front) do
        expect(page).to have_content 'Denver.rb'
        expect(page).to have_css '.carousel-inner .item', text: 'Denver.go', visible: false # the carousel does not boot in this test, for some reason...
      end
    end
  end

  def within_event_card(side=:front)
    within "#card-event .#{side}" do
      yield
    end
  end
end
