class CreateCompanyControls < ActiveRecord::Migration
  def change
    create_table :company_controls do |t|
      t.string  :title
      t.integer :control_classification_id
      t.integer :purpose_id
      t.integer :control_state_id
      t.integer :control_freq_id
      t.integer :standard_id
      t.integer :company_id
      t.text 	:description
      t.timestamps
    end

    add_index :company_controls, :control_classification_id
    add_index :company_controls, :purpose_id
    add_index :company_controls, :control_state_id
    add_index :company_controls, :control_freq_id
    add_index :company_controls, :company_id
    add_index :company_controls, :standard_id
  end
end
