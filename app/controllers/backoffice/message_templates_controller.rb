class Backoffice::MessageTemplatesController < Backoffice::BaseController
  def index; @templates = MessageTemplate.all; end
  def new; @template = MessageTemplate.new; end
  def create
  @template = MessageTemplate.new(template_params)
  if @template.save then redirect_to backoffice_message_templates_path, notice: "Modèle créé"
  else render :new, status: :unprocessable_entity
  end
  end
  def edit; @template = MessageTemplate.find(params[:id]); end
  def update
  @template = MessageTemplate.find(params[:id])
  if @template.update(template_params) then redirect_to backoffice_message_templates_path, notice: "Mis à jour"
  else render :edit, status: :unprocessable_entity
  end
  end
  def destroy
  MessageTemplate.find(params[:id]).destroy
  redirect_to backoffice_message_templates_path, notice: "Supprimé"
  end
  private
  def template_params
  params.require(:message_template).permit(:scope, :subject, :body, :default, :school_id)
  end
end
