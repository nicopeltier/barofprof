class DashboardsController < ApplicationController
  include AuthenticatedArea

  def index
    if current_user.admin?
      if current_school.present?
        # Admin connecté dans une école : dashboard de l'école
        redirect_to dashboard_path
      else
        # Admin sans école : liste des écoles
        redirect_to backoffice_schools_path
      end
    else
      # Directeur : dashboard de son école
      if current_school.present?
        redirect_to dashboard_path
      else
        # Directeur sans école assignée (cas d'erreur)
        redirect_to root_path, alert: t('school.no_school_assigned')
      end
    end
  end

  def control
    @school = current_school
    
    if @school.nil?
      redirect_to root_path, alert: t('school.no_school_selected')
      return
    end
    
    # Données pour l'affichage du dashboard unifié
    @survey = @school.surveys.order(created_at: :desc).first
    @stats  = @survey.present? ? @survey.participations.group(:status).count : {}
  end
end
