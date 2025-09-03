class Backoffice::SchoolsController < Backoffice::BaseController
  def index
    @schools = School.all
  end
  def show; @school = School.find(params[:id]); end
  def new; @school = School.new; end
  def create
    @school = School.new(school_params)
    if @school.save then redirect_to backoffice_schools_path, notice: "École créée"
    else render :new, status: :unprocessable_entity
    end
  end
  def edit; @school = School.find(params[:id]); end
  def update
    @school = School.find(params[:id])
    if @school.update(school_params) then redirect_to backoffice_schools_path, notice: "Mis à jour"
    else render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    School.find(params[:id]).destroy
    redirect_to backoffice_schools_path, notice: "Supprimée"
  end
  def impersonate
    session[:impersonated_school_id] = params[:id]
    redirect_to dashboard_path, notice: "Impersonation activée"
  end
  def stop_impersonating
    session.delete(:impersonated_school_id)
    redirect_to backoffice_schools_path, notice: "Impersonation arrêtée"
  end

  def stop_impersonating_global
    session.delete(:impersonated_school_id)
    redirect_to backoffice_schools_path, notice: "Impersonation arrêtée"
  end
  private
  def school_params
    params.require(:school).permit(:name)
  end
end
