# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    title "MyString"
    from "2014-08-21 09:34:05"
    to "2014-08-22 09:34:05"
  end
end
