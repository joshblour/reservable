# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation, :class => 'Reservable::Reservation' do
    association :reservable, :factory => :room     
    reason "reason"
    category "cat"
    reserved_on {Date.today}
    association :reserver, :factory => :booking
  end
end
