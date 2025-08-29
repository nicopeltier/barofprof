class CreateSurveyThemes < ActiveRecord::Migration[8.0]
  def change
    create_table :survey_themes do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
