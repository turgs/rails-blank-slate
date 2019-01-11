require "test_helper"

class AccountTest < ActiveSupport::TestCase

  setup do
    @account = accounts(:one_of_all_models)
  end

  def valid_params
    {
      name:             'ABC & Co.',
      signup_email:     'hello@example.com',
      signup_password:  'passwordpasswords'
    }
  end

  test "is valid when has name, email, password" do
    account = Account.new valid_params
    assert account.valid?, "Can't create with valid params: #{account.errors.messages}"
  end
end
