class Avo::Filters::UserStatusFilter < Avo::Filters::SelectFilter
  self.name = "Status"

  def options
    {
      "active"    => "Active",
      "archived"  => "Archived"
    }
  end

  def default
    "active"
  end

  def apply(request, query, value)
    case value
    when "archived" then query.with_discarded.discarded
    else query.kept
    end
  end
end