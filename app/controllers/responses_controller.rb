class ResponsesController < ApplicationController
  layout "public" # optionnel : layout épuré
  
  
  before_action :load_participation
  
  
  def show
    mark_opened_once
    @next = next_question
    if @next.nil?
      render :done and return
    end
  end
  
  
  def answer
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
    theme_ids = @participation.survey.themes.order(:number).ids
    Question.where(theme_id: theme_ids)
    .order("theme_id ASC, position ASC")
    .where.not(id: answered_ids)
    .first
  end
end