class Avo::Resources::UserEquipmentRequirement < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :tenant_id, as: :number
    field :user_id, as: :number
    field :equipment_category_id, as: :number
    field :assignment_id, as: :number
    field :is_adapter, as: :boolean
    field :adapter_name, as: :text
    field :requires, as: :boolean
    field :position, as: :number
    field :tenant, as: :belongs_to
    field :user, as: :belongs_to
    field :equipment_category, as: :belongs_to
    field :assignment, as: :belongs_to
  end
end
