class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_school, :impersonating?


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
end
