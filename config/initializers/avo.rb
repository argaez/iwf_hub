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
end