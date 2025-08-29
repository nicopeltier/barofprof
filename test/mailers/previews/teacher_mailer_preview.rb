# Preview all emails at http://localhost:3000/rails/mailers/teacher_mailer
class TeacherMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/teacher_mailer/invite
  def invite
    TeacherMailer.invite
  end

  # Preview this email at http://localhost:3000/rails/mailers/teacher_mailer/reminder
  def reminder
    TeacherMailer.reminder
  end
end
