class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?   = admin? || can?(:index)
  def show?    = admin? || can?(:show)
  def create?  = admin? || can?(:create)
  def new?     = create?
  def update?  = admin? || can?(:update)
  def edit?    = update?
  def destroy? = admin? || can?(:destroy)

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      @scope.all
    end
  end

  private

  def admin?
    user.super_admin? || user.admin?
  end

  def rrhh?
    admin? || user.rrhh?
  end

  def resource_name
    record.is_a?(Class) ? record.name : record.class.name
  end

  def can?(action)
    perm = permissions[resource_name]
    return false unless perm
    case action
    when :index   then perm.can_index
    when :show    then perm.can_show
    when :create  then perm.can_create
    when :update  then perm.can_update
    when :destroy then perm.can_destroy
    else false
    end
  end

  def permissions
    @permissions ||= ActsAsTenant.without_tenant do
      Permission.where(role: user.role).index_by(&:resource)
    end
  end
end