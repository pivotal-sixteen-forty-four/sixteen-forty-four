require 'rails_helper'

describe 'cards' do
  it 'shows instructions for knoll', type: :feature do
    visit '/'

    within '.card', text: 'Knoll' do
      expect(page).to have_content(I18n.t('companies.knoll.title'))
      expect(page).to have_content(I18n.t('companies.knoll.floor'))
      expect(page).to have_content(I18n.t('companies.knoll.suite'))
      expect(page).to have_content(I18n.t('companies.knoll.instructions'))

      page.first('div', text: 'Knoll').click

      expect(page).to have_content('Susan Example')
    end

    within '.card', text: 'Pivotal' do
      expect(page).to have_content(I18n.t('companies.pivotal.title'))
      expect(page).to have_content(I18n.t('companies.pivotal.floor'))
      expect(page).to have_content(I18n.t('companies.pivotal.suite'))
      expect(page).to have_content(I18n.t('companies.pivotal.instructions'))

      page.first('div', text: 'Pivotal').click

      expect(page).to have_content('Brian Rose')
    end

    within '.card', text: 'Galvanize' do
      expect(page).to have_content(I18n.t('companies.galvanize.title'))
      expect(page).to have_content(I18n.t('companies.galvanize.floor'))
      expect(page).to have_content(I18n.t('companies.galvanize.suite'))
      expect(page).to have_content(I18n.t('companies.galvanize.instructions'))

      page.first('div', text: 'Galvanize').click

      expect(page).to have_content('Jeff Dean')
    end
  end
end