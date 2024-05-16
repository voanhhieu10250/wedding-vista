class CreateCommonQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :common_questions do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
