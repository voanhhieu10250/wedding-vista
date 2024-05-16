class AddServiceToCommonQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :common_questions, :service, null: false, foreign_key: true
  end
end
