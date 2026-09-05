class Avo::Filters::EquipmentStatusFilter < Avo::Filters::SelectFilter
  self.name = "Status"

  def options
    {
      "available"   => "Available",
      "assigned"    => "Assigned",
      "maintenance" => "Maintenance",
      "retired"     => "Retired"
    }
  end

  def apply(request, query, value)
    query.where(status: value)
  end
end