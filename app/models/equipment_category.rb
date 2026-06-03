class EquipmentCategory < ApplicationRecord
  belongs_to :tenant, optional: true
  has_many :equipment, dependent: :restrict_with_error

  validates :name, presence: true
end