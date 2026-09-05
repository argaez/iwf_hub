class Avo::Resources::OnboardingRequest < Avo::Resources::ApplicationResource
  self.title = :id
  self.description = "Employee onboarding requests"

  def fields
    field :id,           as: :id, hide_on: :index

    field :user,         as: :belongs_to, name: "Employee"
    field :tenant,       as: :belongs_to, name: "Company",
      visible: -> { current_user.super_admin? || current_user.admin? }

    field :request_date, as: :date,    name: "Request Date"
    field :start_date,   as: :date,    name: "Start Date"

    # Computer
    field :new_computer,              as: :boolean, name: "New Computer"
    field :pc_name_or_previous_owner, as: :text,    name: "PC Name / Previous Owner"
    field :pc_asset_tag,              as: :text,    name: "Asset Tag"

    # Remote Access
    field :remote_access_needed, as: :boolean, name: "Remote Access Needed"
    field :new_remote_user,      as: :boolean, name: "New Remote User"
    field :previous_remote_user, as: :text,    name: "Remote User"
    field :remote_department,    as: :text,    name: "Remote Department"

    # Applications
    field :applications_other, as: :text, name: "Other Applications"

    # Telephony
    field :existing_phone, as: :boolean,      name: "Existing Phone"
    field :extension,      as: :belongs_to,   name: "Extension"

    field :notes,          as: :textarea,     name: "Notes"
    field :pdf_document,   as: :file,         name: "PDF Document"
  end
end