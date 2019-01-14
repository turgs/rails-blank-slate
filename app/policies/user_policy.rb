class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @resolve ||= scope.where(account_id: user.account_id)
    end
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    true
  end

  def update?
    scope.where(id: record.id).exists?
    # if user.admin?
    #   scope.where(id: record.id).exists?
    # else
    #   scope.where(id: record.id).exists? && record.id.eql?(user.id)
    # end
  end

  def destroy?
    scope.where(id: record.id).exists? && scope.size > 1
  end

  def permitted_attributes
    [
      :email,
      :password
    ]
  end
end
