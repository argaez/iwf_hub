class Avo::Filters::EquipmentAssetTagFilter < Avo::Filters::TextFilter
  self.name = "Search by Asset Tag"

  def apply(request, query, value)
    query.where("asset_tag ILIKE ?", "%#{value}%")
  end
end