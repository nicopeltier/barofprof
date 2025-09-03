class Survey < ApplicationRecord
  belongs_to :school
  has_many :survey_themes, dependent: :destroy
  has_many :themes, through: :survey_themes
  has_many :participations, dependent: :destroy
  has_many :question_responses, through: :participations
  
  enum :status, { draft: 0, launched: 1, closed: 2 }
end