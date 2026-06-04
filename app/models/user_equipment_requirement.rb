class UserEquipmentRequirement < ApplicationRecord
  acts_as_tenant :tenant

  belongs_to :tenant
  belongs_to :user
  belongs_to :equipment_category
  belongs_to :assignment, optional: true

  before_validation :inherit_tenant_from_user, on: :create

  scope :standard, -> { where(is_adapter: false).order(:position) }
  scope :adapters, -> { where(is_adapter: true).order(:position) }

  def status
    return :no_requiere unless requires
    return :asignado    if assignment_id.present?
    :pendiente
  end

  def status_label
    { no_requiere: "No requiere", pendiente: "Pendiente", asignado: "Asignado" }[status]
  end

  def status_color
    { no_requiere: "#6B7280", pendiente: "#EF4444", asignado: "#10B981" }[status]
  end

  private

  def inherit_tenant_from_user
    self.tenant_id ||= user&.tenant_id
  end
end