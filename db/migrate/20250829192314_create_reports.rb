class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.references :survey, null: false, foreign_key: true
      t.integer :format
      t.datetime :generated_at

      t.timestamps
    end
  end
end
