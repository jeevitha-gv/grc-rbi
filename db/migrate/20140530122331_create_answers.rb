class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :nc_question_id
      t.integer :value
      t.text :detailed_value

      t.timestamps
    end
  end
end
