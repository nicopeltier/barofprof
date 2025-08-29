class CreateMessageTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :message_templates do |t|
      t.integer :scope
      t.string :subject
      t.text :body
      t.boolean :default
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
