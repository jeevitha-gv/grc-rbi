class CreateRiskCategories < ActiveRecord::Migration
  def change
    create_table :risk_categories do |t|
      t.string :name
      t.integer :company_id

      t.timestamps
    end
  end
end
