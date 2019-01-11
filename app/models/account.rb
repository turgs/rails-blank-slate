class Account < ApplicationRecord
  has_many :users, dependent: :destroy

  attr_accessor :signup_email,
                :signup_password,
                :signup_detected_state,
                :signup_detected_country,
                :signup_detected_ip_address,
                :signup_detected_user_agent

  validates :name, presence: true

  # on create only
  validates :signup_email, presence: { message: 'Please enter your email' }, on: :create
  validates :signup_email, format: { with: %r{.+@.+\z}i, message: "The email you entered isn't an email address!" }, on: :create
  validate  :email_unique, on: :create
  validates :signup_password, length: { minimum: 8, maximum: 300, message: 'Password needs to be between 16 and 100 characters long' }, on: :create
  validate  :password_pwned?, on: :create

  private

    def email_unique
      return if signup_email.blank?
      errors.add :signup_email, 'Your email is already registered. Please login.' if User.find_by_email(signup_email.downcase).present?
    end

    def password_pwned?
      return if signup_password.blank?
      errors.add :signup_password, "Please choose a different password. That password is banned as it's too common." if User.pwned_check(signup_password) == 'pwned'
    end

end
