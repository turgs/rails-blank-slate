require "test_helper"

describe UsersController do
  let(:user) { users :one }

  it "gets index" do
    get users_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_user_url
    value(response).must_be :success?
  end

  it "creates user" do
    expect {
      post users_url, params: { user: { account_id: user.account_id, auth_token: user.auth_token, email: user.email, password_digest: user.password_digest, password_reset_sent_at: user.password_reset_sent_at, password_reset_token: user.password_reset_token } }
    }.must_change "User.count"

    must_redirect_to user_path(User.last)
  end

  it "shows user" do
    get user_url(user)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_user_url(user)
    value(response).must_be :success?
  end

  it "updates user" do
    patch user_url(user), params: { user: { account_id: user.account_id, auth_token: user.auth_token, email: user.email, password_digest: user.password_digest, password_reset_sent_at: user.password_reset_sent_at, password_reset_token: user.password_reset_token } }
    must_redirect_to user_path(user)
  end

  it "destroys user" do
    expect {
      delete user_url(user)
    }.must_change "User.count", -1

    must_redirect_to users_path
  end
end
