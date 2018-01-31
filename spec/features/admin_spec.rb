require 'rails_helper'

describe 'Event management' do
  before do
    configure_oauth_user(provider: :google_oauth2, email: 'not-real-admin@pivotal.io')
    Admin.create!(email: 'not-real-admin@pivotal.io')
  end

  it 'can add new admins' do
    visit '/admins'


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

    Admin.create!(email: 'another-admin-email@pivotal.io')

    click_on 'Login with Google'

    click_on 'Admins'
    within 'tr', text: 'another-admin-email@pivotal.io' do
      click_on 'Delete'
    end

    handle_js_confirm :accept

    expect(page).to have_no_css 'tr', text: 'another-admin-email@pivotal.io'
  end

  it 'can modify employee information for companies' do
    visit '/admins'

    click_on 'Login with Google'

    click_on 'Companies'
    click_on 'New Company'
    fill_in 'Name', with: 'Pied Piper'
    fill_in 'Floor', with: '1'
    fill_in 'Suite', with: '1'
    fill_in 'Instructions', with: 'Walk in the front door and turn right'
    fill_in 'Phone', with: '303-722-1555'
    fill_in 'Website', with: 'pied-piper.com'

    click_on 'New Org Unit'
    fill_in 'Org Unit Name', with: 'The company'
    click_on 'New Contact'
    fill_in 'Contact Name', with: 'Richard Hendriks'
    fill_in 'Contact Title', with: 'CEO'
    click_on 'Submit'

    visit '/'
    within '#card-pied-piper' do
      expect(page).to have_content("Pied Piper")
      expect(page).to have_content("FL 1")
      expect(page).to have_content("Suite 1")
      expect(page).to have_content("Walk in the front door and turn right")
    end

    page.first('div', text: 'Pied Piper').click
    within '#card-pied-piper' do
      expect(page).to have_content("Richard Hendriks")
      expect(page).to have_content("CEO")
    end
  end
end