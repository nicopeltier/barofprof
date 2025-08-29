class School < ApplicationRecord
    enum status: { created: 0, directors_invited: 1, directors_connected: 2, questionnaire: 3, closed: 4 }
    validates :name, presence: true
    end