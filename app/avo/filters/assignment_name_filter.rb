class Avo::Filters::AssignmentNameFilter < Avo::Filters::TextFilter
  self.name = "Search by Employee"

  def apply(request, query, value)
    query.joins(:user)
         .where("users.full_name ILIKE ?", "%#{value}%")
  end
end