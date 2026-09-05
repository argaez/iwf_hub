class Avo::Resources::Equipment < Avo::Resources::ApplicationResource
  self.title = :display_name

  def fields
    field :id,            as: :id,   hide_on: :index
    field :asset_tag,     as: :text, name: "Asset Tag"
    field :serial_number, as: :text, name: "Serial Number"
    field :brand,         as: :text, name: "Brand"
    field :model,         as: :text, name: "Model"
    field :tenant, as: :belongs_to, name: "Company", visible: admin_visible
    field :equipment_category, as: :belongs_to, name: "Category"
    field :vendor,        as: :belongs_to, name: "Vendor"
    field :purchase_date,  as: :date,   name: "Purchase Date"
    field :purchase_price, as: :text,   name: "Purchase Price (COP)",
      hide_on: [:index],
      format_using: -> {
        view.form? ? value : (value.present? ? "$#{value.to_f.round(0).to_i.to_s.reverse.gsub(/\d{3}(?=\d)/, "\\0.").reverse}" : "—")
      }
    field :warranty_end, as: :date, name: "Warranty End"
    field :status, as: :text, name: "Status",
      hide_on: [:new, :edit],
      format_using: -> {
        colors = {
          "available"   => "#059669",
          "assigned"    => "#3B82F6",
          "maintenance" => "#F59E0B",
          "retired"     => "#6B7280"
        }
        labels = {
          "available"   => "Available",
          "assigned"    => "Assigned",
          "maintenance" => "Maintenance",
          "retired"     => "Retired"
        }
        c = colors[value.to_s] || "#6B7280"
        l = labels[value.to_s] || value.to_s.capitalize
        "<span style='background:#{c}22;color:#{c};padding:3px 12px;border-radius:99px;font-size:12px;font-weight:600;'>#{l}</span>".html_safe
      }
    field :status, as: :select, name: "Status",
      hide_on: [:index, :show],
      options: {
        "Available"   => "available",
        "Maintenance" => "maintenance"
      }
    field :location,          as: :belongs_to, name: "Location"
    field :notes,             as: :textarea,   name: "Notes"
    field :assignments,       as: :has_many,   name: "Assignment History"
    field :equipment_events,  as: :has_many,   name: "Equipment Events"
  end
    def filters
      filter Avo::Filters::EquipmentStatusFilter
      filter Avo::Filters::EquipmentCategoryFilter
      filter Avo::Filters::EquipmentAssetTagFilter
      filter Avo::Filters::EquipmentUserFilter
    end

    def actions
      action Avo::Actions::RetireEquipment
    end
end
