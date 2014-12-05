class CreateThreats < ActiveRecord::Migration
  def change
    create_table :threats do |t|
      t.integer :company_id
      t.string :name

      t.timestamps
    end
  end
end
