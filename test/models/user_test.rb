require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    @account = accounts(:one_of_all_models)
  end

  def valid_params
    {
      account_id: @account.id,
      email:      'hello@example.com',
      password:   'passwordpasswords'
    }
  end

  test "is valid when has account, email, password" do
    user = User.new valid_params
    assert user.valid?, "Can't create with valid params: #{user.errors.messages}"
  end

end
