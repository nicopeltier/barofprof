class DirectorMailer < ApplicationMailer
  default from: 'questionnaire@peps.school'

  def invitation_email(school_director)
    @school_director = school_director
    @school = school_director.school
    @user = school_director.user
    @login_url = "https://baroprof.peps.school/users/sign_in"
    
    mail(
      to: @user.email,
      subject: "Invitation à rejoindre #{@school.name} sur Baroprof"
    )
  end
end
