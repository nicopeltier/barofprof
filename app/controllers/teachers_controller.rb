class TeachersController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :check_survey_not_launched, except: [:index, :show]
  
  def index
    @teachers = @school.teachers.order(:last_name, :first_name)
  end

  def show
  end

  def new
    @teacher = @school.teachers.build
  end

  def create
    @teacher = @school.teachers.build(teacher_params)
    
    if @teacher.save
      redirect_to teachers_path, notice: 'Professeur créé avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to teachers_path, notice: 'Professeur modifié avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_path, notice: 'Professeur supprimé avec succès.'
  end
  
  def import_preview
    render 'import'
  end
  
  def import
    unless params[:file].present?
      redirect_to import_preview_teachers_path, alert: "Veuillez sélectionner un fichier."
      return
    end

    file = params[:file]
    unless file.original_filename.end_with?('.xlsx')
      redirect_to import_preview_teachers_path, alert: "Format de fichier non supporté. Utilisez un fichier .xlsx"
      return
    end

    begin
      imported_count = import_teachers_from_excel(file)
      redirect_to teachers_path, notice: "#{imported_count} professeurs importés avec succès."
    rescue => e
      redirect_to import_preview_teachers_path, alert: "Erreur lors de l'import : #{e.message}"
    end
  end

  private

  def import_teachers_from_excel(file)
    require 'roo'
    
    spreadsheet = Roo::Spreadsheet.open(file.tempfile.path)
    header = spreadsheet.row(1).map { |cell| cell.to_s.downcase.strip }
    
    # Mapping des colonnes avec gestion flexible
    email_col = find_column_index(header, ['email', 'e-mail', 'mail'])
    first_name_col = find_column_index(header, ['prénom', 'prenom', 'firstname', 'first_name'])
    last_name_col = find_column_index(header, ['nom', 'lastname', 'last_name'])
    
    raise "Colonne 'email' introuvable" unless email_col
    
    imported_count = 0
    
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      
      email = row[email_col]&.to_s&.strip
      next if email.blank?
      
      first_name = first_name_col ? row[first_name_col]&.to_s&.strip : nil
      last_name = last_name_col ? row[last_name_col]&.to_s&.strip : nil
      
      # Chercher ou créer le professeur
      teacher = @school.teachers.find_or_initialize_by(email: email)
      
      teacher.assign_attributes(
        first_name: first_name.presence || teacher.first_name,
        last_name: last_name.presence || teacher.last_name
      )
      
      if teacher.save
        imported_count += 1
      end
    end
    
    imported_count
  end
  
  def find_column_index(header, possible_names)
    possible_names.each do |name|
      index = header.index(name.downcase)
      return index if index
    end
    nil
  end
  
  def set_school
    @school = current_school
  end

  def set_teacher
    @teacher = @school.teachers.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email)
  end

  def check_survey_not_launched
    current_survey = @school.surveys.order(created_at: :desc).first
    if current_survey&.status.in?(['launched', 'closed'])
      status_text = current_survey.status == 'launched' ? 'en cours' : 'clôturé'
      redirect_to teachers_path, alert: "Impossible de modifier les professeurs : le sondage est #{status_text}."
    end
  end
end