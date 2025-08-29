class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :status
      t.string :slug
      t.jsonb :settings_json

      t.timestamps
    end
  end
end
