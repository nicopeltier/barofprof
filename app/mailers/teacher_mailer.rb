class TeacherMailer < ApplicationMailer
  default from: ENV.fetch("MAILER_FROM", "no-reply@example.com")
  
  
  def invite(participation_id)
    @participation = Participation.find(participation_id)
    @link = respond_url(token: @participation.token)
    mail to: @participation.teacher.email, subject: "Invitation à participer à l'enquête BaroProf"
  end
  
  
  def reminder(participation_id)
    @participation = Participation.find(participation_id)
    @link = respond_url(token: @participation.token)
    mail to: @participation.teacher.email, subject: "Relance pour participer à l'enquête BaroProf"
  end
end