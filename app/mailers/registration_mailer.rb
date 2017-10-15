class RegistrationMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail to: user, subject: 'Welcome to Bike Berlin'
  end
end
