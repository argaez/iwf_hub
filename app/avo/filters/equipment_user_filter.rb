class Avo::Filters::EquipmentUserFilter < Avo::Filters::TextFilter
  self.name = "Search by Employee"

  def apply(request, query, value)
    assigned_equipment_ids = Assignment
      .joins(:user)
      .where("users.full_name ILIKE ?", "%#{value}%")
      .where(returned_at: nil)
      .pluck(:equipment_id)
    query.where(id: assigned_equipment_ids)
  end
end