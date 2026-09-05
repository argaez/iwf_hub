class AddRetirementFieldsToEquipment < ActiveRecord::Migration[8.1]
  def change
    add_column :equipment, :retirement_reason, :string
    add_column :equipment, :retirement_date, :date
  end
end
