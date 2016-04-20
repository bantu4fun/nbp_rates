class Exchange < ActiveRecord::Base
  has_many :currencies, dependent: :destroy

  validates :name, presence: true
  validates :quotation_date, presence: true
  validates :publication_date, presence: true

  def save_current_rates(data)
    exchange = data[:exchanges]
    
    return if Exchange.find_by(name: exchange[:name])

    self.name = exchange[:name]
    self.quotation_date = exchange[:quotation_date]
    self.publication_date = exchange[:publication_date]
    
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
