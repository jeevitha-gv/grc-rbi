class AddCloseEvaluationIdToClose < ActiveRecord::Migration
  def change
    add_column :closes, :close_evaluation_id, :integer
  end
end
