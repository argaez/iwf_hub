class Avo::Resources::Extension < Avo::Resources::ApplicationResource
  self.title = :number
  self.description = "Phone extensions list"
  self.default_sort_column    = :number
  self.default_sort_direction = :asc

  def fields
    field :number, as: :number, name: "Extension"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :user,       as: :belongs_to, name: "Employee", optional: true
    field :department, as: :text,       name: "Department",
      hide_on: [:new, :edit],
      format_using: -> { record.user&.department&.name || "—" }
    field :status, as: :text, name: "Status",
      hide_on: [:new, :edit],
      format_using: -> {
        if record.available?
          "<span style='background:#05966922;color:#059669;padding:3px 12px;border-radius:99px;font-size:12px;font-weight:600;'>Available</span>".html_safe
        else
          "<span style='background:#3B82F622;color:#3B82F6;padding:3px 12px;border-radius:99px;font-size:12px;font-weight:600;'>In Use</span>".html_safe
        end
      }
    field :notes, as: :text, name: "Notes"
  end
end