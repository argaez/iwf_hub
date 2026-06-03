class CreateEquipmentCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :equipment_categories do |t|
      t.string :name
      t.integer :lifespan_years
      t.references :tenant, null: true, foreign_key: true

      t.timestamps
    end
  end
end
