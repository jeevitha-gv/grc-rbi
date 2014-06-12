class AddIsAnsweredToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :is_answered, :boolean, :default => false
  end
end
