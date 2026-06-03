class EquipmentEvent < ApplicationRecord
  belongs_to :equipment

  validates :event_type, presence: true
  validates :event_date, presence: true

  enum :event_type, {
    maintenance: "maintenance",
    repair: "repair",
    inspection: "inspection",
    upgrade: "upgrade"
  }
end