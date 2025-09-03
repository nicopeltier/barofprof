class TeachersController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  
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
    # TODO: parser le fichier et afficher le diff (créations/màj/archives)
  end
  
  def import
    # TODO: appliquer la synchro par email
    redirect_to school_survey_path(@school, current_survey), notice: "Import lancé"
  end 
  
  private
  
  def set_school
    @school = current_school
  end

  def set_teacher
    @teacher = @school.teachers.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email)
  end
end