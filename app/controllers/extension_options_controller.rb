class ExtensionOptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    extensions = ActsAsTenant.without_tenant {
      Extension.where(user_id: nil)
    }
    extensions = extensions.where(tenant_id: params[:tenant_id]) if params[:tenant_id].present?
    render json: extensions.map { |e| { id: e.id, number: e.number } }
  end
end