module AdminVisible
  def admin_visible
    -> { current_user.super_admin? || current_user.admin? }
  end
end