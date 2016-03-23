class SessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.from_omniauth(request.env["omniauth.auth"])

    if @admin
      session[:user_id] = @admin.id
      flash[:error] = t('sessions.new.success')
      redirect_back fallback_location: events_path
    else
      redirect_to new_session_path, notice: t('sessions.new.must_be_admin')
    end
  end
end