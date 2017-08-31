class ContactMailer < ApplicationMailer
  def contact_form(name:, email:, message:)
    @name = name
    @email = email
    @message = message

    mail to: Rails.application.config.contact_mail_address, subject: "New message dropped by #{name}"
  end
end
