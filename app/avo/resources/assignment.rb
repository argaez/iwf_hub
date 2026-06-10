class Avo::Resources::Assignment < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :assigned_at, as: :date_time
    field :assigned_by, as: :text
    field :condition_in, as: :text
    field :condition_out, as: :text
    field :notes, as: :textarea
    field :expected_return_date, as: :date
    field :returned_at, as: :date_time
    field :equipment_id, as: :number
    field :user_id, as: :number
    field :equipment, as: :belongs_to
    field :user, as: :belongs_to
  end
end
