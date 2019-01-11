class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @resolve ||= scope.where(id: user.account_id)
    end
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def update?
    scope.where(id: record.id).exists?
  end

  def permitted_attributes
    [
      :name,
      :signup_email,
      :signup_password,
      :signup_detected_state,
      :signup_detected_country,
      :signup_detected_ip_address,
      :signup_detected_user_agent
    ]
  end
end
