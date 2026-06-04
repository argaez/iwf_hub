class UserPolicy < ApplicationPolicy
  def index?
    admin_or_rrhh?
  end

  def show?
    admin_or_rrhh? || record == user
  end

  def update?
    admin_or_rrhh? || record == user
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user.super_admin? || user.admin?
  end

  def admin_or_rrhh?
    admin? || user.rrhh?
  end
end
