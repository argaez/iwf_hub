class Avo::Filters::ExtensionStatusFilter < Avo::Filters::SelectFilter
  self.name = "Status"

  def options
    {
      "available" => "Available",
      "in_use"    => "In Use"
    }
  end

  def apply(request, query, value)
    case value
    when "available" then query.available
    when "in_use"    then query.in_use
    else query
    end
  end
end