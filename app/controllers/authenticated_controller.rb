class AuthenticatedController < ApplicationController
  before_action :authenticate!

  private

  def authenticate!
    unless current_user.admin?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= Admin.find_by(id: session[:user_id]) || GuestUser.new
  end

  class GuestUser
    def admin?
      false
    end
  end
end