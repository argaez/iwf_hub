class EquipmentEvent < ApplicationRecord
  belongs_to :equipment

  TIPOS = {
    "Purchase"    => "purchase",
    "Repair"      => "repair",
    "Maintenance" => "maintenance",
    "Inspection"  => "inspection",
    "Upgrade"     => "upgrade"
  }.freeze

  enum :event_type, {
    purchase:    "purchase",
    repair:      "repair",
    maintenance: "maintenance",
    inspection:  "inspection",
    upgrade:     "upgrade"
  }

  validates :event_type, presence: true
  validates :event_date, presence: true
end