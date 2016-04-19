class MoneyController < ApplicationController

  def index
    @exchanges = Exchange.all.order(name: :desc).page(params[:page]).per(10)
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
    if Exchange.new.save_current_rates(XmlParser.new.get_data)
      flash[:notice] = 'Rates has been updated.'
      redirect_to money_index_path
    else
      flash[:danger] = 'Rates are up-to-date.'
      redirect_to money_index_path
    end
  end

  def report
    #generate a report for selected currency
    #report should show: basic statistics: mean, median, average
    #also You can generate a simple chart(use can use some js library)

    #this method should be available only for currencies which exist in the database 
  end


end
