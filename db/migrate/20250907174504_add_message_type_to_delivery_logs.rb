class AddMessageTypeToDeliveryLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :delivery_logs, :message_type, :integer
  end
end
