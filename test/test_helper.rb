ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module SignInHelper
  def sign_in(user)
    session[:user_id] = user.id
  end
end

class ActiveSupport::TestCase
  include SignInHelper
  ActiveRecord::Migration.check_pending!
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  self.use_transactional_tests = true

  # Add more helper methods to be used by all tests here...
  extend MiniTest::Spec::DSL
  register_spec_type self do |desc|
    desc < ActiveRecord::Base if desc.is_a? Class
  end

  # Allow context to be used like describe
  class << self
    alias :context :describe
  end
end

class ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    clear_enqueued_jobs
  end

  def teardown
  end
end
