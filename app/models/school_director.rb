class SchoolDirector < ApplicationRecord
  belongs_to :school
  belongs_to :user
  validates :user_id, uniqueness: { scope: :school_id }
  
  before_create :generate_invitation_token
  
  def invited?
    invited_at.present?
  end
  
  def invitation_accepted?
    invitation_accepted_at.present?
  end
  
  def invitation_pending?
    invited? && !invitation_accepted?
  end
  
  private
  
  def generate_invitation_token
    self.invitation_token = SecureRandom.urlsafe_base64(32)
  end
end
