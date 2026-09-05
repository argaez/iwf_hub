class Avo::Resources::Department < Avo::Resources::ApplicationResource
  self.title = :name

  def fields
    field :id,     as: :id,         hide_on: :index
    field :name,   as: :text,       name: "Name"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :users,  as: :has_many,   name: "Employees"
  end
end
