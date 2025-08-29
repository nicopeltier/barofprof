class QuestionResponse < ApplicationRecord
  belongs_to :participation
  belongs_to :survey
  belongs_to :theme
  belongs_to :question
  
  
  validates :score, inclusion: { in: 1..10 }
  end