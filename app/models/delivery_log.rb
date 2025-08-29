class DeliveryLog < ApplicationRecord
  belongs_to :participation
  enum channel: { email: 0, sms: 1 }
  enum status: { queued: 0, sent: 1, failed: 2 }
  end