class ExchangeUpdater < ActiveJob::Base
  queue_as :default

  def perform
    exchange = Exchange.new.save_current_rates(XmlParser.new.get_data)
    if exchange
      ExchangeEmail.perform_later
    end
  end
end