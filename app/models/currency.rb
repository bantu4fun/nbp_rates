class Currency < ActiveRecord::Base
  belongs_to :exchange

  validates :name, presence: true
  validates :converter, presence: true
  validates :converter, numericality: { only_integer: true }
  validates :code, presence: true
  validates :buy_price, presence: true
  validates :buy_price, numericality: true
  validates :sell_price, presence: true
  validates :sell_price, numericality: true

  def self.median(column_name)
    median_index = (count / 2)
    order(column_name).offset(median_index).limit(1).pluck(column_name)[0]
  end
  
end
