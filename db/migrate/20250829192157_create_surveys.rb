class CreateSurveys < ActiveRecord::Migration[8.0]
  def change
    create_table :surveys do |t|
      t.references :school, null: false, foreign_key: true
      t.integer :status
      t.datetime :launched_at
      t.datetime :closed_at

      t.timestamps
    end
  end
end
