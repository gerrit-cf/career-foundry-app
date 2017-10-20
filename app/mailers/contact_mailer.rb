class ContactMailer < ApplicationMailer
  def contact_form(**attributes)
    @name = attributes[:name]
    @email = attributes[:email]
    @message = attributes[:message]

    mail to: Rails.application.config.contact_mail_address, subject: "New message dropped by #{@name}"
  end
end
