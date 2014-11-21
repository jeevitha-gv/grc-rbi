class RemoveExpectedLifeFromSourceCode < ActiveRecord::Migration
  def change
    remove_column :source_codes, :expected_life, :string
    remove_column :source_codes, :project_manager, :string
    remove_column :source_codes, :assigned_on, :date
  end
end
