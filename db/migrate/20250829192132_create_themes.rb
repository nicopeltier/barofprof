class CreateThemes < ActiveRecord::Migration[8.0]
  def change
    create_table :themes do |t|
      t.integer :number
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
