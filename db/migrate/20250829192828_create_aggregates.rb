class CreateAggregates < ActiveRecord::Migration[8.0]
  def change
    create_table :aggregates do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.decimal :avg_score, precision: 4, scale: 2
      t.integer :responses_count

      t.timestamps
    end
  end
end
