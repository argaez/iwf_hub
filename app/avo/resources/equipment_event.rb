class Avo::Resources::EquipmentEvent < Avo::Resources::ApplicationResource
  self.model_class = ::EquipmentEvent

  def fields
    field :id,           as: :id,         hide_on: :index
    field :equipment,    as: :belongs_to, name: "Equipment"
    field :event_type,   as: :select,     name: "Event Type",
      include_blank: false,
      options: EquipmentEvent::TIPOS
    field :event_date,   as: :date,       name: "Date"
    field :cost,         as: :number,     name: "Cost (COP)"
    field :performed_by, as: :text,       name: "Performed By"
    field :notes,        as: :textarea,   name: "Notes"
  end
end