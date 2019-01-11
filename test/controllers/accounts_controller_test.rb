require "test_helper"

describe AccountsController do
  let(:account) { accounts :one }

  it "gets index" do
    get accounts_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_account_url
    value(response).must_be :success?
  end

  it "creates account" do
    expect {
      post accounts_url, params: { account: { name: account.name } }
    }.must_change "Account.count"

    must_redirect_to account_path(Account.last)
  end

  it "shows account" do
    get account_url(account)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_account_url(account)
    value(response).must_be :success?
  end

  it "updates account" do
    patch account_url(account), params: { account: { name: account.name } }
    must_redirect_to account_path(account)
  end

  it "destroys account" do
    expect {
      delete account_url(account)
    }.must_change "Account.count", -1

    must_redirect_to accounts_path
  end
end
