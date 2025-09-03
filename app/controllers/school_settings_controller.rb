class SchoolSettingsController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :ensure_access_to_school

  def edit
    @themes = Theme.all
  end

  def update
    if @school.update(school_params)
      redirect_to edit_school_settings_path, notice: t('school.settings_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_theme
    theme_id = params[:theme_id].to_i
    
    unless @school.can_modify_themes?
      redirect_to edit_school_settings_path, alert: t('school.cannot_modify_themes')
      return
    end

    selected_ids = @school.selected_theme_ids
    
    if selected_ids.include?(theme_id)
      # Désélectionner le thème
      selected_ids.delete(theme_id)
    else
      # Sélectionner le thème
      selected_ids << theme_id
    end
    
    @school.selected_theme_ids = selected_ids
    
    if @school.save
      redirect_to edit_school_settings_path, notice: t('school.theme_updated')
    else
      redirect_to edit_school_settings_path, alert: t('school.theme_update_failed')
    end
  end

  private

  def set_school
    @school = current_school
  end

  def ensure_access_to_school
    unless @school.present?
      redirect_to root_path, alert: t('school.no_school_selected')
    end

    # Vérifier que l'utilisateur a accès à cette école
    unless current_user.admin? || @school.school_directors.exists?(user_id: current_user.id)
      redirect_to root_path, alert: t('school.access_denied')
    end
  end

  def school_params
    params.require(:school).permit(:name, :status, settings_json: {})
  end
end
