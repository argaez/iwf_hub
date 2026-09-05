class Avo::Resources::User < Avo::Resources::ApplicationResource
  self.model_class = ::User
  self.title = :full_name
  self.find_record_method = -> { query.with_discarded.find(id) }

  def fields
    field :id,              as: :id,       hide_on: :index
    field :document_number, as: :text,     name: "Document Number"
    field :full_name,       as: :text,     name: "Full Name"
    field :email,           as: :text,     name: "Corporate Email"
    field :role, as: :select, name: "Role",
      options: {
        "Employee"    => "employee",
        "Consulta"    => "consulta",
        "RRHH"        => "rrhh",
        "Admin"       => "admin",
        "Super Admin" => "super_admin"
      }
    field :password, as: :password, name: "Password",
      hide_on: [:index, :show],
      help: "Leave blank to keep current password"
    field :password_confirmation, as: :password, name: "Confirm Password",
      hide_on: [:index, :show]
    field :personal_email,   as: :text,     name: "Personal Email"
    field :phone,            as: :text,     name: "Phone"
    field :position,         as: :text,     name: "Position"
    field :hire_date,        as: :date,     name: "Hire Date"
    field :termination_date, as: :date,     name: "Contract End Date",
      hide_on: [:index, :show],
      help: "Leave empty if contract is indefinite"
    field :notes,            as: :textarea, name: "Notes"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :department,       as: :belongs_to, name: "Department"
    
    tool Avo::ResourceTools::OnboardingPanel, only_on: :new
    tool Avo::ResourceTools::EquipmentProfile,  only_on: :show
    tool Avo::ResourceTools::OnboardingProfile, only_on: :show
  end
    def filters
      filter Avo::Filters::UserStatusFilter
    end
end 