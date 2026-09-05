class Avo::Resources::Equipment < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :asset_tag, as: :text
    field :brand, as: :text
    field :model, as: :text
    field :serial_number, as: :text
    field :status, as: :select, enum: ::Equipment.statuses
    field :purchase_date, as: :date
    field :purchase_price, as: :number
    field :warranty_end, as: :date
    field :notes, as: :textarea
    field :equipment_category_id, as: :number
    field :location_id, as: :number
    field :vendor, as: :belongs_to, name: "Vendor"
    field :tenant_id, as: :number
    field :tenant, as: :belongs_to
    field :equipment_category, as: :belongs_to
    field :location, as: :belongs_to
    field :assignments, as: :has_many
    field :equipment_events, as: :has_many
  end
end
