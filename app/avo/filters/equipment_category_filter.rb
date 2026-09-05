class Avo::Filters::EquipmentCategoryFilter < Avo::Filters::SelectFilter
  self.name = "Category"

  def options
    EquipmentCategory.all.map { |c| [c.id.to_s, c.name] }.to_h
  end

  def apply(request, query, value)
    query.where(equipment_category_id: value.to_i)
  end
end