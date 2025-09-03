class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_school, :impersonating?


  def current_school
    if session[:impersonated_school_id]
      School.find(session[:impersonated_school_id])
    else
      # à remplacer par la logique école↔directeur si nécessaire
      School.first
    end
  end

  def impersonating?
    session[:impersonated_school_id].present?
  end
end
