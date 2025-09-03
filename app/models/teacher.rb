class Teacher < ApplicationRecord
  belongs_to :school
  validates :email, presence: true
  attribute :archived, :boolean, default: false
  
  before_create :generate_response_token
  before_save :ensure_response_token
  
  private
  
  def generate_response_token
    self.response_token = SecureRandom.urlsafe_base64(32)
  end
  
  def ensure_response_token
    generate_response_token if response_token.blank?
  end
end