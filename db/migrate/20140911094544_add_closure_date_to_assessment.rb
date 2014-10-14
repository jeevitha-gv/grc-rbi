class AddClosureDateToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :closure_date, :date
  end
end
