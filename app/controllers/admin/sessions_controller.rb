class Admin::SessionsController < Devise::SessionsController
  layout false

  def after_sign_in_path_for(resource)
    "/avo"
  end

  def after_sign_out_path_for(resource)
    "/admin/login"
  end
end