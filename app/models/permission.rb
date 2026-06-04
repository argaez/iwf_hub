class Permission < ApplicationRecord
  ROLES = %w[super_admin admin rrhh employee consulta].freeze
  RESOURCES = %w[Equipment User Department Location Supplier EquipmentCategory Assignment EquipmentEvent Extension OnboardingRequest].freeze

  validates :role,     presence: true, inclusion: { in: ROLES }
  validates :resource, presence: true, inclusion: { in: RESOURCES }
  validates :role,     uniqueness: { scope: :resource, message: "ya tiene permisos definidos para este recurso" }

  def label
    "#{role.capitalize} — #{resource}"
  end
end
