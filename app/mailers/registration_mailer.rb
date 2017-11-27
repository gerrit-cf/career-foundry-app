class RegistrationMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail to: user.email, subject: 'Welcome to Bike Berlin'
  end
end
