class AddResponseTokenToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :response_token, :string
    add_index :teachers, :response_token, unique: true
  end
end
