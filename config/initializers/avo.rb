Avo.configure do |config|
  ## == Routing ==
  config.root_path = '/avo'

  ## == Authentication ==
  config.current_user_method do
    warden.authenticate(scope: :user)
  end

  config.authenticate_with do
    user = warden.authenticate(scope: :user)
    if user.nil?
      redirect_to "/admin/login"
    elsif !user.super_admin? && !user.admin?
      redirect_to "/", alert: "No tienes permisos para acceder al panel."
    end
  end

  ## == Authorization ==
  config.authorization_client = nil
  config.explicit_authorization = true

  ## == Branding ==
  config.app_name = "IWF Hub"

  ## == Resource options ==
  config.click_row_to_view_record = true

  ## == Menus ==
  config.main_menu = -> {
    section "Administración", icon: "avo/resources" do
      resource :tenant,     label: "Empresas"
      resource :user,       label: "Usuarios"
      resource :department, label: "Departamentos"
      resource :permission, label: "Permisos"
    end

    section "Inventario", icon: "avo/resources" do
      resource :equipment,          label: "Equipos"
      resource :equipment_category, label: "Categorías"
      resource :assignment,         label: "Asignaciones"
      resource :equipment_event,    label: "Eventos"
      resource :location,           label: "Ubicaciones"
      resource :supplier,           label: "Proveedores"
    end

    section "Onboarding", icon: "avo/resources" do
      resource :onboarding_request,         label: "Solicitudes"
      resource :extension,                  label: "Extensiones"
      resource :extension_range,            label: "Rangos"
      resource :user_equipment_requirement, label: "Requisitos"
    end
  }
end