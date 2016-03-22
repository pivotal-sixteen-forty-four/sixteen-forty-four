class Admin < ApplicationRecord
  def admin?
    true
  end

  def self.from_omniauth(params)
    admin = self.find_by(email: params.info.email)
    if admin
      admin.update!(
        provider: params.provider,
        uid: params.uid,
        email: params.info.email,
        name: params.info.name,
        token: params.credentials.token,
      )
    end
    admin
  end
end
