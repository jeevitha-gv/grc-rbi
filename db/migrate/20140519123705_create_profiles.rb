class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.integer	:user_id
      t.string  :first_name
      t.string  :last_name
      t.string  :personal_email
      t.string  :phone_no
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :country

      t.timestamps
    end
  end
end
