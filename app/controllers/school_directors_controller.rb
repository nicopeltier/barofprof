class SchoolDirectorsController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :set_school_director, only: [:show, :edit, :update, :destroy]
  
  def index
    @school_directors = @school.school_directors.includes(:user).order('users.email')
  end

  def show
  end

  def new
    @school_director = @school.school_directors.build
  end

  def create
    email = params[:school_director][:email]
    
    # Trouver ou créer l'utilisateur
    user = User.find_by(email: email)
    if user.nil?
      # Créer un nouvel utilisateur avec un mot de passe temporaire
      user = User.create!(
        email: email,
        password: SecureRandom.hex(10),
        admin: false
      )
    end
    
    # Vérifier que l'utilisateur n'est pas déjà directeur de cette école
    if @school.school_directors.exists?(user: user)
      redirect_to school_directors_path, alert: t('directors.already_director')
      return
    end
    
    @school_director = @school.school_directors.build(user: user)
    
    if @school_director.save
      redirect_to school_directors_path, notice: t('directors.added_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @available_users = available_users_for_director(@school_director.user)
  end

  def update
    if @school_director.update(school_director_params)
      redirect_to school_directors_path, notice: t('directors.modified_successfully')
    else
      @available_users = available_users_for_director(@school_director.user)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school_director.destroy
    redirect_to school_directors_path, notice: t('directors.removed_successfully')
  end

  def invite
    @school_director = @school.school_directors.find(params[:id])
    @school_director.update!(
      invited_at: Time.current,
      invitation_token: SecureRandom.urlsafe_base64(32)
    )
    
    # Envoyer l'email d'invitation
    DirectorMailer.invitation_email(@school_director).deliver_now
    
    redirect_to school_directors_path, notice: t('directors.invitation_sent_successfully')
  end

  def resend_invitation
    @school_director = @school.school_directors.find(params[:id])
    @school_director.update!(invited_at: Time.current)
    
    # Renvoyer l'email d'invitation
    DirectorMailer.invitation_email(@school_director).deliver_now
    
    redirect_to school_directors_path, notice: t('directors.invitation_resent_successfully')
  end
  
  private
  
  def set_school
    @school = current_school
  end

  def set_school_director
    @school_director = @school.school_directors.find(params[:id])
  end

  def school_director_params
    params.require(:school_director).permit(:user_id)
  end

  def available_users_for_director(current_user = nil)
    # Users qui ne sont pas admin et qui ne sont pas déjà directeurs d'une autre école
    # (sauf l'utilisateur actuel en cas d'édition)
    assigned_user_ids = SchoolDirector.where.not(user_id: current_user&.id).pluck(:user_id)
    User.where(admin: false)
        .where.not(id: assigned_user_ids)
        .order(:email)
  end
end
