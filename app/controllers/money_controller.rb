class MoneyController < ApplicationController

  def index
    @exchanges = Exchange.all
  end

  def show
    @exchange = Exchange.find(params[:id])
    if @exchange
      @currencies = @exchange.currencies.all
    else
      redirect_to money_path
    end
  end

  def refresh_rates
    #for manual refreshing
    #get latest exchange rates and save to db
    #can be helpful: 
    #http://www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
  end

  def report
    #generate a report for selected currency
    #report should show: basic statistics: mean, median, average
    #also You can generate a simple chart(use can use some js library)

    #this method should be available only for currencies which exist in the database 
  end


end
