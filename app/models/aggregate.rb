class Aggregate < ApplicationRecord
  belongs_to :survey
  belongs_to :theme, optional: true
  belongs_to :question, optional: true
end