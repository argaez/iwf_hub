class Avo::Resources::Vendor < Avo::Resources::ApplicationResource
  self.title = :name
  self.model_class = ::Vendor

  def fields
    field :id,            as: :id,       hide_on: :index
    field :name,          as: :text,     name: "Name"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :contact_email, as: :text,     name: "Contact Email"
    field :contact_phone, as: :text,     name: "Contact Phone"
    field :notes,         as: :textarea, name: "Notes"
  end
end