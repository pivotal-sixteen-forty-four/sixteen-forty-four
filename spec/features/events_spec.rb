require 'rails_helper'

describe 'Event management' do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      :info => {
        :name => "John Doe",
        :email => "not-real-but-admin@pivotal.io",
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

  it 'does not allow non-admins to manage events' do
    Admin.create!(email: 'not-real-admin@pivotal.io')
    visit '/events'

    expect(page).to have_content 'You must be logged in to manage events.'
    click_on 'Login with Google'
    expect(page).to have_content 'You must be an admin to manage events.'
  end

  it 'requires a google account tied to an admin account' do
    Event.create!(name: 'FooEvent')
    Admin.create!(email: 'not-real-but-admin@pivotal.io')
    visit '/events'

    expect(page).to have_content 'You must be logged in to manage events.'
    click_on 'Login with Google'
    expect(page).to have_content 'FooEvent'
  end
end