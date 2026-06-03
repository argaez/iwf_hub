class CreateSuppliers < ActiveRecord::Migration[8.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_email
      t.string :contact_phone
      t.text :notes
      t.references :tenant, null: true, foreign_key: true

      t.timestamps
    end
  end
end
