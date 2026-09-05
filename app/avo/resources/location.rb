class Avo::Resources::Location < Avo::Resources::ApplicationResource
  self.model_class = ::Location
  self.title = :name

  def fields
    field :id,        as: :id,         hide_on: :index
    field :name,      as: :text,       name: "Name"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :equipment, as: :has_many,   name: "Equipment in this location"
  end
end