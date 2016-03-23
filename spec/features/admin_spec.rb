require 'rails_helper'

describe 'Event management' do
  before do
    configure_oauth_user(provider: :google_oauth2, email: 'not-real-admin@pivotal.io')
  end

  it 'can add new admins' do
    visit '/admins'

    Admin.create!(email: 'not-real-admin@pivotal.io')

    expect(page).to have_content I18n.t('sessions.new.logged_in')
    click_on 'Login with Google'

    click_on 'Admins'
    click_on 'New Admin'
    fill_in 'Email', with: 'another-admin-email@pivotal.io'
    click_on 'Save'
    expect(page).to have_content 'Success'
  end

  it 'can remove admins' do
    visit '/admins'

    Admin.create!(email: 'not-real-admin@pivotal.io')
    Admin.create!(email: 'another-admin-email@pivotal.io')

    click_on 'Login with Google'

    click_on 'Admins'
    within 'tr', text: 'another-admin-email@pivotal.io' do
      click_on 'Delete'
    end

    handle_js_confirm :accept

    expect(page).to have_no_css 'tr', text: 'another-admin-email@pivotal.io'
  end
end