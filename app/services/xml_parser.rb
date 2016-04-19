require 'nokogiri'
require 'open-uri'

class XmlParser

  def initialize(filename: 'LastC.xml')
    @filename = filename
    @data = { exchanges: {}, currencies: [] }
  end

  def get_data
    parse
  end


  private

  def parse
    xml = Nokogiri::XML(open("http://www.nbp.pl/kursy/xml/#{@filename}"))

    @data[:exchanges][:name] = xml.css('numer_tabeli').text
    @data[:exchanges][:quotation_date] = xml.css('data_notowania').text.to_date
    @data[:exchanges][:publication_date] = xml.css('data_publikacji').text.to_date

    xml.css('pozycja').each do |node|
      currency = {}
      currency[:name] = node.css('nazwa_waluty').text
      currency[:converter] = node.css('przelicznik').text.to_i
      currency[:code] = node.css('kod_waluty').text
      currency[:buy_price] = node.css('kurs_kupna').text.gsub!(',','.').to_f
      currency[:sell_price] = node.css('kurs_sprzedazy').text.gsub!(',','.').to_f

      @data[:currencies] << currency
    end
    @data
  end
end