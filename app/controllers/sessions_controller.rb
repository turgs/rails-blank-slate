class SessionsController < ApplicationController
  layout "login"
  skip_before_action :require_login
  skip_after_action :verify_authorized


  # this is the login page
  def new
    @timestamp = Time.zone.now.strftime("%s") # this is used to reject the login form if it's too stale
  end

  # this will process the login submission
  def create
    # find if email exists
    user = User.find_by_email(submitted_params[:email].downcase)

    # check login credentials
    # use CLOUDFLARE WORKERS to check whinnie is blank, piglet is populated, device is SEEN BEFORE

    unless user
      redirect_to(login_path, notice: "Incorrect Email.") and return
    end

    # check login credentials
    # ------------------------

    # password incorrect
    unless user.authenticate(submitted_params[:password])
      redirect_to(login_path, notice: "Incorrect Password.<br>Try again, or you can also #{view_context.link_to('Reset Your Password', new_password_reset_path)}.", flash: { html_safe: true }) and return
    end

    # set login cookie
    session[:user_id] = user.id

    # force stronger password is needed
    if submitted_params[:password].length < 8
      user&.send_password_reset(false)
      redirect_to(edit_password_reset_path(user.password_reset_token), notice: "<p><b>The password you're using is no longer strong enough.</b></p><p>Please create a new password.</p><p>It's best to choose a password you <b>cannot remember</b> &mdash; one you <b>need</b> to write down in a <br>'passwords book'.</p><p>The big security risk isn't your friends going through your purse looking for paper with your password on it, it's the hackers trying to force their way in using automated robots. </p>") and return
    end

    # let them in!
    redirect_to root_url
  end

  def destroy
    notice = flash[:notice] if flash[:notice].present?
    log_logout_attempt
    reset_session
    flash[:notice] = (notice.present? ? notice : 'Logged out.')
    redirect_to login_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def submitted_params
    # @submitted_params ||= params.require(:session).permit(:email, :password, :remember_me)
    @submitted_params ||= params.permit(
      [
        :email,
        :password,
        :remember_me,
        :referrer,
        :whinnie,
        :piglet,
        :timestamp
      ]
    )
  end
end
