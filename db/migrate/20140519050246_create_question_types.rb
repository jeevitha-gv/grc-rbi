class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
      t.string :name
      t.timestamps
    end

    # QuestionType.create([{name: ''}])
    # QuestionType.create([{name: ''}])
    # QuestionType.create([{name: ''}])
  end
end
