require 'rails_helper'

describe 'cards' do
  before do
    Event.delete_all
    visit '/'
    page.driver.browser.manage.window.resize_to(1920, 1160)
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
      expect(page).to have_content('Susan Example')

      sleep(14)
      expect(page).to have_css('.card-flipper--flipped')
      sleep(1)
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

      sleep(14)
      expect(page).to have_css('.card-flipper--flipped')
      sleep(1)
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
      expect(page).to have_content('Jeff Dean')

      sleep(14)
      expect(page).to have_css('.card-flipper--flipped')
      sleep(1)
      expect(page).to_not have_css('.card-flipper--flipped')
    end
  end

  context 'when there is no upcoming event' do
    it 'shows generic building information' do
      start_at = Time.current.advance(hours: -3)
      ends_at = start_at.advance(hours: 3)
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
      Event.create!(name: 'Denver.rb', floor: '2', suite: '200', description: 'Denver ruby meetup', starts_at: start_at, ends_at: ends_at)

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
end