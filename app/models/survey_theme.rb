class SurveyTheme < ApplicationRecord
  belongs_to :survey
  belongs_to :theme
  validates :theme_id, uniqueness: { scope: :survey_id }
  default_scope { order(position: :asc) }
end