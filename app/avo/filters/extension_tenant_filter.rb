class Avo::Filters::ExtensionTenantFilter < Avo::Filters::SelectFilter
  self.name = "Company"

  def options
    ActsAsTenant.without_tenant do
      Tenant.order(:name).each_with_object({}) { |t, h| h[t.id.to_s] = t.name }
    end
  end

  def apply(request, query, value)
    query.where(tenant_id: value)
  end
end