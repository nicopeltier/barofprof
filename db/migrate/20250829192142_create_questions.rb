class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :theme, null: false, foreign_key: true
      t.text :label
      t.boolean :active
      t.integer :position

      t.timestamps
    end
  end
end
