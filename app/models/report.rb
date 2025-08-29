class Report < ApplicationRecord
  belongs_to :survey
  enum format: { pdf: 0 }
  has_one_attached :file
  end
