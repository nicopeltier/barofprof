class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_school, :impersonating?

  before_action :mark_invitation_accepted, if: :user_signed_in?

  def current_school
    if session[:impersonated_school_id]
      School.find(session[:impersonated_school_id])
    elsif current_user&.admin?
      # Admin sans impersonation : pas d'école par défaut
      nil
    else
      # Directeur : récupérer son école
      current_user&.school_directors&.first&.school
    end
  end

  def impersonating?
    session[:impersonated_school_id].present?
  end

  private

  def mark_invitation_accepted
    return if current_user.admin? || impersonating?
    
    # Marquer l'invitation comme acceptée pour les directeurs qui se connectent
    school_director = current_user.school_directors.first
    if school_director && school_director.invited? && !school_director.invitation_accepted?
      school_director.update!(invitation_accepted_at: Time.current)
    end
  end
end
