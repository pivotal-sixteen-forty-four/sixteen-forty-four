module OmniauthHelpers
  def configure_oauth_user(provider:, email:, **user_params)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      provider: provider.to_s,
      uid: user_params.fetch(:uid, '12345'),
      :info => {
        :name => user_params.fetch(:name, 'John Doe'),
        :email => email,
        :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      },
      :credentials => {
        :token => user_params.fetch(:token, 'token'),
        :refresh_token => user_params.fetch(:refresh_token, 'refresh-token'),
      },
      :extra => {
        :raw_info => {
          :sub => "123456789",
          :email => email,
        }
      }
    })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end
end