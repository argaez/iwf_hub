class Avo::Resources::ExtensionRange < Avo::Resources::ApplicationResource
  self.title = :label
  self.description = "Extension ranges by company"

  def fields
    field :id,          as: :id,         hide_on: :index
    field :tenant,      as: :belongs_to, name: "Company"
    field :label,       as: :text,       name: "Label",  required: true
    field :range_start, as: :number,     name: "From",   required: true
    field :range_end,   as: :number,     name: "To",     required: true
  end
end