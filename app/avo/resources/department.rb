class Avo::Resources::Department < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :tenant_id, as: :number
    field :tenant, as: :belongs_to
    field :users, as: :has_many
  end
end
