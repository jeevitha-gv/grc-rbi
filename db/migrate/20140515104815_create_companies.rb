class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :primary_email
      t.string :secondary_email
      t.string :domain
      t.string :address1
      t.string :address2
      t.string :timezone
      t.integer :country_id
      t.string :contact_no

      t.timestamps
    end
  end
end
