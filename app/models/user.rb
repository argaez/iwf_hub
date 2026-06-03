class User < ApplicationRecord
  include Discard::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :tenant, optional: true
  belongs_to :department, optional: true
  has_many :assignments, dependent: :restrict_with_error

  enum :role, {
    super_admin: "super_admin",
    admin: "admin",
    rrhh: "rrhh",
    employee: "employee",
    consulta: "consulta"
  }

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true

  scope :active, -> { kept }

  def active_equipment
    assignments.active.includes(:equipment).map(&:equipment)
  end

  def full_name
    self[:full_name].presence || email
  end
end