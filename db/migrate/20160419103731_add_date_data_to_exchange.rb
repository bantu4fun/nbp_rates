class AddDateDataToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :quotation_date, :date
    add_column :exchanges, :publication_date, :date
  end
end
