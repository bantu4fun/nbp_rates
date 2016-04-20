class Currency < ActiveRecord::Base
  belongs_to :exchange

  def self.median(column_name)
    median_index = (count / 2)
    order(column_name).offset(median_index).limit(1).pluck(column_name)[0]
  end
  
end
