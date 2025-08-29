class DashboardsController < ApplicationController
  include AuthenticatedArea

  def control
    @school = current_school
    @survey = @school.surveys.order(created_at: :desc).first
    @stats  = @survey.present? ? @survey.participations.group(:status).count : {}
  end
end
