class Backoffice::BaseController < ApplicationController
  include AuthenticatedArea
  before_action :ensure_admin
  
  private
  
  def ensure_admin
    redirect_to(root_path, alert: "Accès réservé à l'admin") unless current_user&.admin?
  end
end