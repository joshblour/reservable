# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservable_reservation, :class => 'Reservation' do
    association :reservable, :factory => :room     
    reason "MyString"
    category "MyString"
    reserved_on {Date.today}
    association :reserver, :factory => :booking
  end
end
