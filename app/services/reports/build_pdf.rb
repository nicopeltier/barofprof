module Reports
  class BuildPdf
    def self.call(survey)
      require "prawn"
      Prawn::Document.new do |pdf|
        pdf.text "Rapport BaroProf", size: 20, style: :bold
        pdf.move_down 10
        pdf.text "École: #{survey.school.name}"
        pdf.text "Clôturé le: #{survey.closed_at}"
        pdf.move_down 20
        survey.themes.each do |theme|
          pdf.text "Thématique: #{theme.name}", style: :bold
          data = [ [ "Question", "Moyenne", "Réponses" ] ]
          # moyenne par question
          theme.questions.each do |q|
            rows = QuestionResponse.where(survey_id: survey.id, question_id: q.id)
            avg = rows.average(:score)&.round(2) || 0
            data << [ q.label.truncate(60), avg, rows.count ]
          end
          pdf.table(data, header: true)
          pdf.move_down 10
        end
      end.render
    end
  end
end
