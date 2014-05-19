class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
      t.string :name
      t.timestamps
    end
    QuestionType.create([{name: 'Yes or No'}])
    QuestionType.create([{name: 'Descriptive Type'}])
    QuestionType.create([{name: 'Multiple Choice'}])
  end
end
