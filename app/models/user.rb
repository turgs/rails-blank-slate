class User < ApplicationRecord
  has_secure_password

  belongs_to :account

  validates :account, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: /@/
  validates :password, length: { minimum: 8, maximum: 300 }, presence: true, on: :create
  validates :password, length: { minimum: 8, maximum: 300 }, allow_blank: true, on: :update
  validate :password_pwned?

  scope :ordered, -> { order(:created_at) }

  def password_pwned?
    return if password.blank?
    errors.add :password, :pwned if User.pwned_check(password) == 'pwned'
  end

  def self.pwned_check(password)
    return 'pwned' if password.blank?
    return 'pwned' if password == 'passwordpassword'
    return 'safe' if Rails.env.test?

    password_hash = Digest::SHA1.hexdigest(password).upcase
    begin
      require 'net/http'
      url = URI.parse "https://api.pwnedpasswords.com/range/#{password_hash[0,5]}"
      res = ::Net::HTTP.get_response(url)
    rescue StandardError => e
      Rails.logger.fatal "#{__FILE__}:#{__LINE__}: Couldn't check user's password against Have I Been Pwned. Maybe it's down.. or timing out: #{e.to_s}".bg_red
      return 'safe'
    end

    unless res.code == '200'
      Rails.logger.fatal "#{__FILE__}:#{__LINE__}: Couldn't check user's password against Have I Been Pwned. (Response Code #{res.code})".bg_red
      return 'safe'
    end

    return 'pwned' if res.body.include? password_hash.last(-5)
    'safe'
  end
end
