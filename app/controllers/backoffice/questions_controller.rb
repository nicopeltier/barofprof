class Backoffice::QuestionsController < Backoffice::BaseController
  before_action :set_theme
  def index; @questions = @theme.questions; end
  def new; @question = @theme.questions.new; end
  def create
  @question = @theme.questions.new(question_params)
  if @question.save then redirect_to backoffice_theme_questions_path(@theme), notice: "Question créée"
  else render :new, status: :unprocessable_entity
  end
  end
  def edit; @question = @theme.questions.find(params[:id]); end
  def update
  @question = @theme.questions.find(params[:id])
  if @question.update(question_params) then redirect_to backoffice_theme_questions_path(@theme), notice: "Mis à jour"
  else render :edit, status: :unprocessable_entity
  end
  end
  def destroy
  @theme.questions.find(params[:id]).destroy
  redirect_to backoffice_theme_questions_path(@theme), notice: "Supprimée"
  end
  private
  def set_theme; @theme = Theme.find(params[:theme_id]); end
  def question_params
  params.require(:question).permit(:label, :active, :position)
  end
end
