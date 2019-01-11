class PasswordResetsController < ApplicationController
  layout "login"
  skip_before_action :require_login
  skip_after_action :verify_authorized

  def create
    if params[:email].present?
      user = User.find_by_email(params[:email])
      user&.send_password_reset(true)
      redirect_to login_url, notice: "Email sent with instructions."
    else
      @error = "Enter your email address."
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Your Password Reset has Expired.<br><br>Please request a " + link_to('new password reset', new_password_reset_path) + ".".html_safe
    elsif @user.update_attributes(params[:user].permit(:password))
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Password has been saved. You are now logged in."
    else
      render :edit
    end
  end
end
