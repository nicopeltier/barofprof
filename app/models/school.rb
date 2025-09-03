class School < ApplicationRecord
  has_many :surveys, dependent: :destroy
  has_many :school_directors, dependent: :destroy
  has_many :teachers, dependent: :destroy
  enum :status, { created: 0, directors_invited: 1, directors_connected: 2, questionnaire: 3, closed: 4 }
  validates :name, presence: true
end