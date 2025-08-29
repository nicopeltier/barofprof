class SurveysController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :set_survey, only: %i[show launch remind close report]


  def new
    @survey = @school.surveys.new
  end


  def create
    @survey = @school.surveys.new(status: :draft)
    if @survey.save then redirect_to school_survey_path(@school, @survey)
    else render :new, status: :unprocessable_entity
    end
    end


    def show
      @themes = Theme.where(active: true)
    end


    def launch
      # Service à implémenter: Surveys::Launch.call(@survey, params[:theme_ids])
      @survey.update!(status: :launched, launched_at: Time.current)
      redirect_to school_survey_path(@school, @survey), notice: "Campagne lancée"
    end


    def remind
      # ReminderJob.perform_later(@survey.id)
      redirect_to school_survey_path(@school, @survey), notice: "Relances en file"
    end


    def close
      # Agrégations + anonymisation
      Survey.transaction do
        @survey.update!(status: :closed, closed_at: Time.current)
        Participation.where(survey_id: @survey.id).update_all(teacher_id: nil)
      end
      # Génération PDF
      pdf_bytes = Reports::BuildPdf.call(@survey)
      report = Report.create!(survey: @survey, format: :pdf, generated_at: Time.current)
      report.file.attach(io: StringIO.new(pdf_bytes), filename: "baroprof_rapport.pdf", content_type: "application/pdf")
      redirect_to school_survey_path(@school, @survey), notice: "Campagne clôturée et rapport prêt"
    end


    def report
      # envoi du PDF attaché (ActiveStorage)
    end


    private
    def set_school; @school = current_school; end
    def set_survey; @survey = @school.surveys.find(params[:id]); end
end
