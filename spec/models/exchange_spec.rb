require 'spec_helper'

describe Exchange do
  it { should have_many :currencies }

  it { should have_db_column :id }
  it { should have_db_column :name }
  it { should have_db_column :created_at }
  it { should have_db_column :updated_at }
  it { should have_db_column :quotation_date }
  it { should have_db_column :publication_date }

  it { should validate_presence_of :name }
  it { should validate_presence_of :quotation_date }
  it { should validate_presence_of :publication_date }
  
end
