class EquipmentOptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    equipment = Equipment.where(status: "available")
    equipment = equipment.where(equipment_category_id: params[:category_id]) if params[:category_id].present?
    render json: equipment.map { |e| { id: e.id, name: e.display_name } }
  end
end