require 'rails_helper'

describe 'Event management' do
  before do
    configure_oauth_user(provider: :google_oauth2, email: 'not-real-but-admin@pivotal.io')
  end

  it 'does not allow non-admins to manage events' do
    Admin.create!(email: 'not-real-admin@pivotal.io')
    visit '/events'

    expect(page).to have_content I18n.t('sessions.new.logged_in')
    click_on 'Login with Google'
    expect(page).to have_content I18n.t('sessions.new.must_be_admin')
  end

  it 'requires a google account tied to an admin account' do
    Event.create!(name: 'FooEvent')
    Admin.create!(email: 'not-real-but-admin@pivotal.io')
    visit '/events'

    expect(page).to have_content I18n.t('sessions.new.logged_in')
    click_on 'Login with Google'
    click_on 'Events'
    expect(page).to have_content 'FooEvent'
  end
end