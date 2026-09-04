class Avo::Resources::Vendor < Avo::BaseResource
  self.model_class = ::Vendor

  def fields
    field :id,            as: :id,       hide_on: :index
    field :name,          as: :text,     name: "Name"
    field :tenant,        as: :belongs_to, name: "Company", visible: -> { current_user.super_admin? || current_user.admin? }
    field :contact_email, as: :text,     name: "Contact Email"
    field :contact_phone, as: :text,     name: "Contact Phone"
    field :notes,         as: :textarea, name: "Notes"
  end
end