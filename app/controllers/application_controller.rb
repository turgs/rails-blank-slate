class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action :verify_authorized, except: [:index], if: -> { Rails.env.development? }
  after_action :verify_policy_scoped, only: :index, if: -> { Rails.env.development? }

  before_action :require_login

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  rescue
    reset_session
    redirect_to(logout_path, notice: 'Please re-login.') and return
  end
  helper_method :current_user

  def require_login
    return if current_user
    redirect_to login_path, status: 302
  end
end
