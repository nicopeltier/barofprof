class CreateQuestionResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :question_responses do |t|
      t.references :participation, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :score
      t.datetime :answered_at

      t.timestamps
    end
  end
end
