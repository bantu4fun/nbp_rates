require 'spec_helper'

describe MoneyController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @exchange = FactoryGirl.create(:exchange)
    sign_in @user
  end

  describe "GET 'index'" do
    before do
      @exchanges = Exchange.all.order(id: :desc)
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "should find all exchanges" do
      assigns(:exchanges).should eq([@exchange])
    end

    it "renders the :index view" do
      response.should render_template :index
    end

  end

  describe "GET 'show'" do
    before do
      @currency = FactoryGirl.create(:currency, exchange_id: @exchange.id)
      get :show, id: @exchange
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should find all currencies" do
      assigns(:currencies).should eq([@currency])
    end

    it "renders the :show view" do
      response.should render_template :show
    end
  
  end

  describe "POST 'refresh_rates'" do
    before do
      @currency = FactoryGirl.create(:currency, exchange_id: @exchange.id)
      get :report, id: @currency.id
    end

    it "should be successful" do
      response.should be_success
    end

    it "should find currency" do
      assigns(:currency).should eq(@currency)
    end

    it "renders the :report view" do
      response.should render_template :report
    end

  end

end