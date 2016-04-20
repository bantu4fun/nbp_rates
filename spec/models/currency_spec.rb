require 'spec_helper'

describe Currency do

  it { should belong_to :exchange }

  it { should have_db_column :id }
  it { should have_db_column :name }
  it { should have_db_column :converter }
  it { should have_db_column :code }
  it { should have_db_column :buy_price }
  it { should have_db_column :sell_price }
  it { should have_db_column :exchange_id }

  it { should have_db_index ["exchange_id"] }

  it { should validate_presence_of :name }
  it { should validate_presence_of :converter }
  it { should validate_presence_of :code }
  it { should validate_presence_of :buy_price }
  it { should validate_presence_of :sell_price }
  it { should validate_presence_of :exchange_id }

  it { should validate_numericality_of(:converter).only_integer }
  it { should validate_numericality_of(:buy_price) }
  it { should validate_numericality_of(:sell_price) }
  
end
