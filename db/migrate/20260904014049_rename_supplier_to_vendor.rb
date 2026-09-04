class RenameSupplierToVendor < ActiveRecord::Migration[8.1]
  def change
    rename_table :suppliers, :vendors
    rename_column :equipment, :supplier_id, :vendor_id
  end
end