class Backoffice::ThemesController < Admin::BaseController
  def index
    @themes = Theme.all
  end
  def new
    @theme = Theme.new
  end
  def create
    @theme = Theme.new(theme_params)
    if @theme.save then redirect_to backoffice_theme_path, notice: "Thématique créée"
    else render :new, status: :unprocessable_entity
    end
    end
    def edit; @theme = Theme.find(params[:id]); end
    def update
      @theme = Theme.find(params[:id])
      if @theme.update(theme_params) then redirect_to backoffice_theme_path, notice: "Mis à jour"
      else render :edit, status: :unprocessable_entity
      end
      end
      def destroy
        Theme.find(params[:id]).destroy
        redirect_to backoffice_theme_path, notice: "Supprimée"
      end
      private
      def theme_params
        params.require(:theme).permit(:number, :name, :active)
      end
end
