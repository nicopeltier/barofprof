class CreateDeliveryLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :delivery_logs do |t|
      t.references :participation, null: false, foreign_key: true
      t.integer :channel
      t.integer :status
      t.string :provider_message_id
      t.datetime :sent_at
      t.text :error_message

      t.timestamps
    end
  end
end
