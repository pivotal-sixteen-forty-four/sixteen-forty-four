require 'rails_helper'

describe 'Event management' do
  before do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      :info => {
        :name => "John Doe",
        :email => "not-real-admin@pivotal.io",
        :first_name => "John",
        :last_name => "Doe",
        :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      },
      :credentials => {
        :token => "token",
        :refresh_token => "another_token",
      },
      :extra => {
        :raw_info => {
          :sub => "123456789",
          :email => "user@domain.pivotal.io",
        }
      }
    })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
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