class CreateEquipment < ActiveRecord::Migration[8.1]
  def change
    create_table :equipment do |t|
      t.string :asset_tag
      t.string :brand
      t.string :model
      t.string :serial_number
      t.string :status
      t.date :purchase_date
      t.decimal :purchase_price
      t.date :warranty_end
      t.text :notes
      t.references :equipment_category, null: true, foreign_key: true
      t.references :location, null: true, foreign_key: true
      t.references :supplier, null: true, foreign_key: true
      t.references :tenant, null: true, foreign_key: true

      t.timestamps
    end
  end
end
