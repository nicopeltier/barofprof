class SurveyMailer < ApplicationMailer
  default from: 'noreply@baroprof.com'

  def invitation(teacher, survey)
    @teacher = teacher
    @survey = survey
    @school = survey.school
    @response_url = respond_url(token: teacher.response_token)
    
    mail(
      to: teacher.email,
      subject: "Invitation à participer au questionnaire - #{@school.name}"
    )
  end

  def reminder(teacher, survey)
    @teacher = teacher
    @survey = survey
    @school = survey.school
    @response_url = respond_url(token: teacher.response_token)
    
    mail(
      to: teacher.email,
      subject: "Rappel - Questionnaire en cours - #{@school.name}"
    )
  end
end
