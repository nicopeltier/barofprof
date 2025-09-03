class Participation < ApplicationRecord
  belongs_to :survey
  belongs_to :teacher, optional: true # deviendra nil après anonymisation
  has_many :question_responses, dependent: :destroy
  
  enum :status, { not_opened: 0, opened: 1, in_progress: 2, completed: 3 }
  
  # Token sera défini manuellement lors de la création via teacher.response_token
end