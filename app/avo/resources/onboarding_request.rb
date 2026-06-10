class Avo::Resources::OnboardingRequest < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :tenant_id, as: :number
    field :request_date, as: :date
    field :start_date, as: :date
    field :new_computer, as: :boolean
    field :pc_name_or_previous_owner, as: :text
    field :pc_asset_tag, as: :text
    field :remote_access_needed, as: :boolean
    field :new_remote_user, as: :boolean
    field :previous_remote_user, as: :text
    field :remote_department, as: :text
    field :applications, as: :code
    field :applications_other, as: :text
    field :brand_new_phone, as: :boolean
    field :existing_phone, as: :boolean
    field :extension_id, as: :number
    field :distribution_lists, as: :code
    field :notes, as: :textarea
    field :pdf_document, as: :file
    field :user, as: :belongs_to
    field :tenant, as: :belongs_to
    field :extension, as: :belongs_to
  end
end
