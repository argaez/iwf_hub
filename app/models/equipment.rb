class Equipment < ApplicationRecord
  belongs_to :tenant, optional: true
  belongs_to :equipment_category
  belongs_to :location, optional: true
  belongs_to :vendor, optional: true

  has_many :assignments, dependent: :restrict_with_error
  has_many :equipment_events, dependent: :destroy

  validates :brand, presence: true
  validates :status, presence: true
  validates :asset_tag, uniqueness: { scope: :tenant_id, message: "ya existe para esta empresa" }, allow_blank: true
  validates :serial_number, uniqueness: { scope: :tenant_id, message: "ya existe para esta empresa" }, allow_blank: true

  enum :status, {
    available: "available",
    assigned: "assigned",
    maintenance: "maintenance",
    retired: "retired"
  }

  def current_user
    assignments.where(returned_at: nil).includes(:user).first&.user
  end
  def display_name
  asset_info  = asset_tag.present? ? "#{asset_tag} · " : ""
  equipo_info = [brand, model].select(&:present?).join(" ")
  prev        = previous_owner
  prev ? "#{asset_info}#{equipo_info} · #{prev.full_name}" : "#{asset_info}#{equipo_info} · New"
end

def previous_owner
  prev = assignments.where.not(returned_at: nil)
                    .order(returned_at: :desc)
                    .first
  prev ? User.with_discarded.find_by(id: prev.user_id) : nil
end
end