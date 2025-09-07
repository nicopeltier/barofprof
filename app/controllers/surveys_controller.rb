class SurveysController < ApplicationController
  include AuthenticatedArea
  before_action :set_school
  before_action :set_survey, only: %i[show launch remind close report]


  def new
    @survey = @school.surveys.new
  end


  def create
    @survey = @school.surveys.new(status: :draft)
    if @survey.save
      # Lancer immédiatement le questionnaire
      launch_survey(@survey)
      redirect_to dashboard_path, notice: "Sondage lancé avec succès. Les emails d'invitation ont été envoyés à tous les professeurs."
    else
      render :new, status: :unprocessable_entity
    end
  end


    def show
      @themes = Theme.where(active: true)
    end


    def launch
      launch_survey(@survey)
      redirect_to dashboard_path, notice: "Questionnaire lancé avec succès. Les emails d'invitation ont été envoyés à tous les professeurs."
    end


    def remind
      # Trouver les professeurs qui n'ont pas terminé le questionnaire
      incomplete_participations = @survey.participations.joins(:teacher)
                                         .where.not(status: 'completed')
      
      reminder_count = 0
      
      # Envoyer les emails de relance
      incomplete_participations.find_each do |participation|
        SurveyMailer.reminder(participation.teacher, @survey).deliver_now
        
        # Enregistrer la relance dans les logs
        participation.delivery_logs.create!(
          channel: :email,
          status: :sent,
          message_type: :reminder,
          sent_at: Time.current
        )
        
        reminder_count += 1
      end
      
      redirect_to dashboard_path, notice: "#{reminder_count} emails ont été envoyés aux professeurs n'ayant pas encore répondu"
    end


    def close
      # Agrégations + anonymisation
      Survey.transaction do
        @survey.update!(status: :closed, closed_at: Time.current)
        # Anonymiser les participations en supprimant la référence au teacher
        # mais en gardant les question_responses liées via participation_id
        @survey.participations.update_all(teacher_id: nil)
      end
      
      redirect_to dashboard_path, notice: "Questionnaire clôturé avec succès. Le rapport est maintenant disponible au téléchargement."
    end


    def report
      # Générer et télécharger le rapport PDF
      pdf_content = generate_survey_report(@survey)
      send_data pdf_content, 
                filename: "rapport_questionnaire_#{@survey.id}.pdf",
                type: "application/pdf",
                disposition: "attachment"
    end


    private
    def set_school; @school = current_school; end
    def set_survey; @survey = @school.surveys.find(params[:id]); end
    
    def launch_survey(survey)
      # Créer les survey_themes basés sur les thèmes sélectionnés de l'école
      selected_theme_ids = @school.selected_theme_ids
      selected_theme_ids.each do |theme_id|
        survey.survey_themes.find_or_create_by(theme_id: theme_id)
      end
      
      # Créer une participation pour chaque professeur et envoyer l'email
      @school.teachers.find_each do |teacher|
        # Créer la participation avec le token du professeur
        participation = survey.participations.find_or_create_by(teacher: teacher) do |p|
          p.token = teacher.response_token
          p.status = :not_opened
        end
        
        # Envoyer l'email d'invitation
        SurveyMailer.invitation(teacher, survey).deliver_now
      end
      
      survey.update!(status: :launched, launched_at: Time.current)
    end
    
    def generate_survey_report(survey)
      require 'prawn'
      
      Prawn::Document.new do |pdf|
        # Zone 1: Titre principal modifié
        pdf.text "Questionnaire sur le bien-être du corps enseignant", size: 24, style: :bold, align: :center
        pdf.move_down 20
        
        # Zone 2: Informations générales (sans statut)
        pdf.text "École : #{survey.school.name}", size: 14
        pdf.text "Créé le : #{survey.created_at.strftime('%d/%m/%Y')}", size: 12
        pdf.text "Clôturé le : #{survey.closed_at&.strftime('%d/%m/%Y') || 'N/A'}", size: 12
        pdf.move_down 30
        
        # Zone 3: Statistiques de participation avec moyenne globale
        total_participations = survey.participations.count
        completed_participations = survey.participations.where(status: 'completed').count
        
        pdf.text "Statistiques de Participation", size: 18, style: :bold
        pdf.move_down 10
        pdf.text "Total des invitations : #{total_participations}", size: 12
        pdf.text "Questionnaires complétés : #{completed_participations}", size: 12
        pdf.text "Taux de participation : #{total_participations > 0 ? (completed_participations.to_f / total_participations * 100).round(1) : 0}%", size: 12
        
        # Calcul et affichage de la moyenne globale
        if survey.question_responses.any?
          global_avg = survey.question_responses.average(:score).to_f.round(2)
          pdf.text "Moyenne globale : #{global_avg}/10", size: 12, style: :bold
        end
        pdf.move_down 30
        
        # Zone 4: Résultats par question (organisés par thème)
        if survey.question_responses.any?
          pdf.text "Résultats par Question", size: 18, style: :bold
          pdf.move_down 10
          
          survey.themes.order(:number).each do |theme|
            # Vérifier si le thème a des réponses
            theme_responses = survey.question_responses.joins(:question).where(questions: { theme_id: theme.id })
            next unless theme_responses.any?
            
            # Nom du thème et moyenne
            theme_avg = theme_responses.average(:score).to_f.round(2)
            pdf.text theme.name, size: 12, style: :bold
            pdf.text "Moyenne du thème : #{theme_avg}/10", size: 10, style: :bold
            pdf.move_down 5
            
            # Questions du thème avec leurs moyennes
            theme.questions.order(:position).each do |question|
              question_responses = survey.question_responses.where(question_id: question.id)
              if question_responses.any?
                question_avg = question_responses.average(:score).to_f.round(1)
                pdf.text "#{question_avg}/10 : #{question.label}", size: 10
              end
            end
            pdf.move_down 15
          end
        else
          pdf.text "Aucune réponse collectée", size: 14, style: :italic
        end
        
        # Pied de page
        pdf.move_down 50
        pdf.text "Rapport généré le #{Time.current.strftime('%d/%m/%Y à %H:%M')}", size: 10, align: :center, style: :italic
      end.render
    end
end
