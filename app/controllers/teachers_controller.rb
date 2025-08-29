class TeachersController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  
  
  def index
    @teachers = @school.teachers.order(:last_name, :first_name)
  end
  
  
  def import_preview
    # TODO: parser le fichier et afficher le diff (créations/màj/archives)
  end
  
  
  def import
    # TODO: appliquer la synchro par email
    redirect_to school_survey_path(@school, current_survey), notice: "Import lancé"
  end 
  
  
  private
  def set_school
    @school = current_school # à implémenter via session[:impersonated_school_id] ou association directeur
  end
end