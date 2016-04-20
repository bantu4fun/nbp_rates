class CurrenciesMailer < ApplicationMailer
  def currencies_update_email(mail_to)
    mail(to: mail_to, subject: 'Exchange rates update')
  end
end