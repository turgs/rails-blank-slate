class AccountsController < ApplicationController
  layout "login", only: [:new, :create]
  skip_before_action :require_login, only: [:new, :create]
  skip_after_action :verify_authorized, only: [:new, :create]

  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @users = policy_scope(@account.users).ordered
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    if @account.valid?
      ActiveRecord::Base.transaction do
        @account = Account.create! account_params
        @user = @account.users.create! email:    account_params[:signup_email],
                                      password: account_params[:signup_password]
      end
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Welcome.'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to login_path, notice: 'Your account has been deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.account
      authorize @account
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(policy(Account).permitted_attributes)
    end
end
