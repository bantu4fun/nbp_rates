class ExchangeEmail < ActiveJob::Base
  queue_as :default

  def perform
    User.all.each do |user|
      CurrenciesMailer.currencies_update_email(user.email).deliver_now
    end
  end
end