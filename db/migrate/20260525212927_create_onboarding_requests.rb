class CreateOnboardingRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :onboarding_requests do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :tenant,  null: true,  foreign_key: true
      t.date    :request_date,                null: false
      t.date    :start_date

      # Computer
      t.boolean :new_computer,                default: false
      t.string  :pc_name_or_previous_owner
      t.string  :pc_asset_tag

      # Remote access
      t.boolean :remote_access_needed,        default: false
      t.boolean :new_remote_user,             default: false
      t.string  :previous_remote_user
      t.string  :remote_department

      # Applications
      t.json    :applications,                default: []
      t.string  :applications_other

      # Telephony
      t.boolean :brand_new_phone,             default: false
      t.boolean :existing_phone,              default: false
      t.references :extension, null: true,    foreign_key: true

      # Distribution lists
      t.json    :distribution_lists,          default: []
      t.text    :notes

      t.timestamps
    end
  end
end