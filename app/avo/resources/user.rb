class Avo::Resources::User < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :name, as: :text
    field :role, as: :select, enum: ::User.roles
    field :tenant_id, as: :number
    field :full_name, as: :text
    field :document_number, as: :text
    field :phone, as: :text
    field :position, as: :text
    field :hire_date, as: :date
    field :termination_date, as: :date
    field :discarded_at, as: :date_time
    field :department_id, as: :number
    field :tenant, as: :belongs_to
    field :department, as: :belongs_to
    field :assignments, as: :has_many
  end
end
