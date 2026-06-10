class Avo::Resources::Supplier < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :contact_email, as: :text
    field :contact_phone, as: :text
    field :notes, as: :textarea
    field :tenant_id, as: :number
    field :tenant, as: :belongs_to
    field :equipment, as: :has_many
  end
end
