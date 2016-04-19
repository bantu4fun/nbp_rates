class Exchange < ActiveRecord::Base
  require 'nokogiri'
  require 'open-uri'
  
  has_many :currencies

  def save_current_rates
    latest_nbp_xml = get_latest_nbp_xml
    pub_date = latest_nbp_xml.css('data_publikacji').text

    return if Exchange.find_by(name: pub_date)

    self.name = pub_date
    latest_nbp_xml.css('pozycja').each do |node|
      self.currencies.new(parse_rates(node))
    end
    save
  end
  
  private

    def get_latest_nbp_xml
      Nokogiri::XML(open("http://www.nbp.pl/kursy/xml/LastC.xml"))
    end


    def parse_rates(node)
      {
        name: node.css('nazwa_waluty').text,
        converter: node.css('przelicznik').text,
        code: node.css('kod_waluty').text,
        buy_price: node.css('kurs_kupna').text.gsub(',', '.').to_f,
        sell_price: node.css('kurs_sprzedazy').text.gsub(',', '.').to_f
      }
    end

end
