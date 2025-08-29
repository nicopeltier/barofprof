class Question < ApplicationRecord
  belongs_to :theme
  validates :label, presence: true
  attribute :active, :boolean, default: true
  default_scope { order(position: :asc) }
  end