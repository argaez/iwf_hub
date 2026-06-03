class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :tenant, null: true, foreign_key: true

      t.timestamps
    end
  end
end
