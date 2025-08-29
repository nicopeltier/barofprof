class CreateSchoolDirectors < ActiveRecord::Migration[8.0]
  def change
    create_table :school_directors do |t|
      t.references :school, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
