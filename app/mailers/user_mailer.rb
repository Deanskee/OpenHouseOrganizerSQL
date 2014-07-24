class UserMailer < ActionMailer::Base
  default from: "mandile24@gmail.com"

   def welcome_email(user)
    @user = user
    @url  = 'localhost:3000'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

