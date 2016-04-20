# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exchange do
    name "MyString"
    publication_date Faker::Date.forward(14)
    quotation_date Faker::Date.backward(14)
  end
end
