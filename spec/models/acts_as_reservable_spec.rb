require 'rails_helper'

module Reservable

  
  describe ActsAsReservable do
    context '.acts_as_reservable' do
      before(:each) do
        @room = create(:room)
        @booking = create(:booking)
      end
      
      it 'responds' do
        expect(Room).to respond_to :acts_as_reservable
      end
      
      it 'has_many reservations' do
        expect(@room).to have_many :reservations
      end
      
      it 'has_many reservers through reservations' do
        expect(@room).to have_many :reservers
      end
                  
      it 'accepts nested attribtues for reservations' do
        expect(@room).to accept_nested_attributes_for(:reservations).allow_destroy(true)
      end
      
      it 'adds a reservation' do
        expect {
          @room.reserve(reserved_on: 2.days.from_now.to_date, reserver: @booking)
        }.to change{@room.reservations.count}.by(1)
      end
      

      
      it 'removes a reservation' do
        @room.reservations.create(reserved_on: 2.days.from_now.to_date, reserver: @booking)
        
        expect {
          @room.unreserve(reserved_on: 2.days.from_now.to_date, reserver: @booking)
        }.to change{@room.reservations.count}.by(-1)
      end
      
      it 'adds a range of reservations for a single reserver/resource' do        
        expect {
          @room.reserve_range(reserved_from: Date.today, reserved_until: 3.days.from_now.to_date, reserver: @booking)
        }.to change{@room.reservations.count}.by(4)        
      end
      
      it 'removes a range of reservations for a single reserver/resource' do
        @room.reserve_range(reserved_from: Date.today, reserved_until: 3.days.from_now.to_date, reserver: @booking)

        expect {
          @room.unreserve_range(reserved_from: 2.days.from_now.to_date, reserved_until: 3.days.from_now.to_date, reserver: @booking)
        }.to change{@room.reservations.count}.by(-2)              
      end
      
      it 'returns a list of reservations available for N consectutive days within a range' do
      
        @room1 = create(:room)
        @room2 = create(:room)
        @room3 = create(:room)
        @room1.reserve_range(reserved_from: Date.today, reserved_until: 15.days.from_now.to_date, reserver: @booking)
        @room2.reserve_range(reserved_from: Date.today, reserved_until: 10.days.from_now.to_date, reserver: @booking)
        @room3.reserve_range(reserved_from: Date.today, reserved_until: 7.days.from_now.to_date, reserver: @booking)
        @room3.reserve(reserved_on: 14.days.from_now.to_date, reserver: @booking)
        
        @available_rooms = Room.find_available(from: Date.today, to: 18.days.from_now.to_date, days: 5)
        expect(@available_rooms).to eq [@room2, @room3]
      end

      it 'parses string dates' do
        expect {
          @room.reserve(reserved_on: 2.days.from_now.to_s, reserver: @booking)
          @room.unreserve(reserved_on: 2.days.from_now.to_s, reserver: @booking)
          @room.reserve_range(reserved_from: Date.today.to_s, reserved_until: 3.days.from_now.to_s, reserver: @booking)
          @room.unreserve_range(reserved_from: 2.days.from_now.to_s, reserved_until: 3.days.from_now.to_s, reserver: @booking)
          Room.find_available(from: Date.today.to_s, to: "2014-12-05", days: 5)
        }.not_to raise_error

      end

      
    
    end
  end
end
