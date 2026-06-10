class Avo::Resources::EquipmentEvent < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :event_type, as: :select, enum: ::EquipmentEvent.event_types
    field :event_date, as: :date
    field :performed_by, as: :text
    field :cost, as: :number
    field :notes, as: :textarea
    field :equipment_id, as: :number
    field :equipment, as: :belongs_to
  end
end
