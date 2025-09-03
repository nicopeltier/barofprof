class ResponsesController < ApplicationController
  layout "public" # optionnel : layout épuré
  
  
  before_action :load_participation
  
  
  def show
    # Vérifier si le sondage est clôturé
    if @participation.survey.closed?
      render :closed and return
    end
    
    mark_opened_once
    @next = next_question
    if @next.nil?
      render :done and return
    end
    
    # Calculer les informations de progression
    @current_theme = @next.theme
    @theme_position = @participation.survey.themes.order(:number).pluck(:id).index(@current_theme.id) + 1
    @total_themes = @participation.survey.themes.count
    
    @answered_in_theme = @participation.question_responses.where(theme_id: @current_theme.id).count
    @question_position = @answered_in_theme + 1
    @total_questions_in_theme = @current_theme.questions.count
  end
  
  
  def answer
    # Vérifier si le sondage est clôturé
    if @participation.survey.closed?
      redirect_to respond_path(token: @participation.token) and return
    end
    
    q = Question.find(params.require(:question_id))
    score = params.require(:score).to_i
    @participation.question_responses.create!(
    survey_id: @participation.survey_id,
    theme_id: q.theme_id,
    question_id: q.id,
    score: score,
    answered_at: Time.current
    )
    if next_question.nil?
      @participation.update!(status: :completed, completed_at: Time.current)
      redirect_to respond_path(token: @participation.token)
    else
      @participation.update!(status: :in_progress) unless @participation.completed?
      redirect_to respond_path(token: @participation.token)
    end
  end
  
  
  private
  def load_participation
    @participation = Participation.find_by!(token: params[:token])
  end
  def mark_opened_once
    return unless @participation.not_opened?
    @participation.update!(status: :opened, opened_at: Time.current)
  end
  def next_question
    answered_ids = @participation.question_responses.pluck(:question_id)
    
    # Récupérer les thèmes dans l'ordre croissant
    ordered_themes = @participation.survey.themes.order(:number)
    
    # Pour chaque thème, chercher la première question non répondue
    ordered_themes.each do |theme|
      next_question = theme.questions.where.not(id: answered_ids).order(:position).first
      return next_question if next_question
    end
    
    # Aucune question trouvée
    nil
  end
end