class Equipment < ApplicationRecord
  belongs_to :tenant, optional: true
  belongs_to :equipment_category
  belongs_to :location, optional: true
  belongs_to :supplier, optional: true

  has_many :assignments, dependent: :restrict_with_error
  has_many :equipment_events, dependent: :destroy

  validates :brand, presence: true
  validates :status, presence: true
  validates :asset_tag, uniqueness: true, allow_blank: true
  validates :serial_number, uniqueness: true, allow_blank: true

  enum :status, {
    available: "available",
    assigned: "assigned",
    maintenance: "maintenance",
    retired: "retired"
  }

  def current_user
    assignments.where(returned_at: nil).includes(:user).first&.user
  end
end