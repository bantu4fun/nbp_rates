class Exchange < ActiveRecord::Base
  has_many :currencies, dependent: :destroy

  def save_current_rates(data)
    return if Exchange.find_by(name: data[:exchanges][:name])

    self.name = data[:exchanges][:name]
    self.quotation_date = data[:exchanges][:quotation_date]
    self.publication_date = data[:exchanges][:publication_date]
    
    data[:currencies].each do |node|
      self.currencies.new(parse_rates(node))
    end
    save
  end
  
  private

    def parse_rates(node)
      {
        name: node[:name],
        converter: node[:converter],
        code: node[:code],
        buy_price: node[:buy_price],
        sell_price: node[:sell_price]
      }
    end

end
