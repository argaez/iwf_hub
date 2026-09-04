class Avo::Resources::Department < Avo::BaseResource
  self.title = :name

  def fields
    field :id,     as: :id,         hide_on: :index
    field :name,   as: :text,       name: "Name"
    field :tenant, as: :belongs_to, name: "Company",
      visible: -> { current_user.super_admin? || current_user.admin? }
    field :users,  as: :has_many,   name: "Employees"
  end
end
