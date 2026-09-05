class Avo::Resources::EquipmentCategory < Avo::Resources::ApplicationResource
  self.model_class = ::EquipmentCategory
  self.title = :name

  def fields
    field :id,             as: :id,         hide_on: :index
    field :name,           as: :text,       name: "Name"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :lifespan_years, as: :number,     name: "Lifespan (years)"
    field :equipment,      as: :has_many,   name: "Equipment in this category",
      attachable: false
  end
end