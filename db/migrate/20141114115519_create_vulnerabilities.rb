class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.integer :company_id
      t.string :name

      t.timestamps
    end
  end
end
