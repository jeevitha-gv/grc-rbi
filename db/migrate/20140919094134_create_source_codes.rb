class CreateSourceCodes < ActiveRecord::Migration
  def change
    create_table :source_codes do |t|
      t.string :vcs_url
      t.string :project_manager
      t.string :version_number
      t.text :backup_measure
      t.date :assigned_on
      t.string :expected_life

      t.timestamps
    end
  end
end
