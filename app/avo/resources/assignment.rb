class Avo::Resources::Assignment < Avo::BaseResource
  self.model_class = ::Assignment

  def fields
    field :id, as: :id, hide_on: :index

    field :user, as: :belongs_to, name: "Employee"

    field :filter_category_id, as: :select, name: "Category",
      hide_on: [:index, :show],
      include_blank: true,
      options: -> { EquipmentCategory.all.map { |c| [c.name, c.id.to_s] }.to_h }

    field :equipment_id, as: :select, name: "Equipment",
      hide_on: [:index, :show],
      options: -> {
        blank = { "Select..." => "" }
        items = Equipment.where(status: "available").map { |e| [e.display_name, e.id.to_s] }.to_h
        blank.merge(items)
      }

    field :equipment_clean_name, as: :text, name: "Equipment",
      hide_on: [:new, :edit]

    field :assigned_at,          as: :date_time, name: "Assignment Date"
    field :returned_at,          as: :date_time, name: "Return Date"
    field :condition_in,         as: :text,      name: "Condition on Receipt"
    field :condition_out,        as: :text,      name: "Condition on Return"
    field :assigned_by,          as: :text,      name: "Registered By"
    field :expected_return_date, as: :date,      name: "Expected Return Date"
    field :notes,                as: :textarea,  name: "Notes"
  end
end