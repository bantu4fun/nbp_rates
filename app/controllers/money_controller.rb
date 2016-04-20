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
    if Exchange.new.save_current_rates(XmlParser.new.get_data)
      flash[:notice] = 'Rates has been updated.'
      redirect_to money_index_path
    else
      flash[:danger] = 'Rates are up to date.'
      redirect_to money_index_path
    end
  end

  def report
    @currency = Currency.find(params[:id])
    
    if @currency
      currency_code = Currency.where(code: @currency.code)
      @min_buy = currency_code.minimum(:buy_price)
      @max_buy = currency_code.maximum(:buy_price)
      @avg_buy = currency_code.average(:buy_price).round(4)
      @median_buy = currency_code.median(:buy_price)

      @min_sell = currency_code.minimum(:sell_price)
      @max_sell = currency_code.maximum(:sell_price)
      @avg_sell = currency_code.average(:sell_price).round(4)
      @median_sell = currency_code.median(:sell_price)
      
      @chart_data = [
        {
          name: 'Sell price',
          data: currency_code.map do |c| 
              [c.exchange.publication_date.strftime("%d.%m.%Y"), c.send(:sell_price)]
            end.last(10)
        },
        {
          name: 'Buy price',
          data: currency_code.map do |c|
              [c.exchange.publication_date.strftime("%d.%m.%Y"), c.send(:buy_price)]
            end.last(10)
        }
      ]

    end
  end
  
end
