class Teacher < ApplicationRecord
  belongs_to :school
  validates :email, presence: true
  attribute :archived, :boolean, default: false
  end