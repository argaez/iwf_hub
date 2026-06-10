class Avo::Resources::Permission < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :role, as: :text
    field :resource, as: :text
    field :can_index, as: :boolean
    field :can_show, as: :boolean
    field :can_create, as: :boolean
    field :can_update, as: :boolean
    field :can_destroy, as: :boolean
  end
end
