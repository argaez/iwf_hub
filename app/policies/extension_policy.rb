class ExtensionPolicy < ApplicationPolicy
  def index?   = admin? || can?(:index)
  def show?    = admin? || can?(:show)
  def create?  = admin?
  def new?     = admin?
  def update?  = admin?
  def edit?    = admin?
  def destroy? = admin?
end
