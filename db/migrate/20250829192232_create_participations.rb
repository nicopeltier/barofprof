class CreateParticipations < ActiveRecord::Migration[8.0]
  def change
    create_table :participations do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.string :token
      t.integer :status
      t.datetime :opened_at
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :last_seen_at

      t.timestamps
    end
  end
end
