class Avo::Resources::Tenant < Avo::Resources::ApplicationResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :subdomain, as: :text
    field :plan, as: :text
    field :active, as: :boolean
    field :users, as: :has_many
    field :departments, as: :has_many
    field :locations, as: :has_many
    field :suppliers, as: :has_many
    field :equipment_categories, as: :has_many
    field :equipment, as: :has_many
  end
end
