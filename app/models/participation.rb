class Participation < ApplicationRecord
  belongs_to :survey
  belongs_to :teacher, optional: true # deviendra nil après anonymisation
  has_many :question_responses, dependent: :destroy
  
  
  enum status: { not_opened: 0, opened: 1, in_progress: 2, completed: 3 }
  
  
  before_validation :ensure_token
  
  
  private
  def ensure_token
  self.token ||= SecureRandom.base58(24)
  end
  end