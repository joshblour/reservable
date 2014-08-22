require 'rails_helper'

module Reservable

  
  describe ActsAsReserver do
    context '.acts_as_reserver' do
      before(:each) do
        @booking = create(:booking)
        @room = create(:room)
      end
      
      it 'responds' do
        expect(Booking).to respond_to :acts_as_reserver
      end
      
      it 'has_many reservations' do
        expect(@booking).to have_many :reservations
      end
      
      it 'has_many reservables through reservations' do
        expect(@booking).to have_many :reservables
        
      end

      it 'adds a reservation for a specific reservable' do
        expect{
          @booking.reserve(reserved_on: Date.today, reservable: @room)
        }.to change{@booking.reservations.count}.by(1)
        
        expect(@booking.reservations.last.reservable).to eq @room
      end
      
      it 'removes a reservation for a specific reservable' do

        reservation1 = @booking.reserve(reserved_on: Date.today, reservable: @room)
        reservation2 = @booking.reserve(reserved_on: Date.today, reservable: create(:room))
        
        expect{
          @booking.unreserve(reserved_on: Date.today, reservable: @room)
        }.to change{@booking.reservations.count}.by(-1)
        
        expect{reservation1.reload}.to raise_error ActiveRecord::RecordNotFound
        expect{reservation2.reload}.not_to raise_error
      end
      
      it 'adds a range of reservations for a single reservable/resource' do        
        expect {
          @booking.reserve_range(reserved_from: Date.today, reserved_until: 3.days.from_now, reservable: @room)
        }.to change{@booking.reservations.count}.by(4)
        expect(@booking.reservations.map(&:reservable).uniq).to eq [@room]
      end
      
      it 'removes a range of reservations for a single reservable/resource' do
        reservation1 = @booking.reserve(reserved_on: 2.days.from_now, reservable: create(:room))
        
        @booking.reserve_range(reserved_from: Date.today, reserved_until: 3.days.from_now, reservable: @room)

        expect {
          @booking.unreserve_range(reserved_from: 2.days.from_now, reserved_until: 3.days.from_now, reservable: @room)
        }.to change{@booking.reservations.count}.by(-2)
        
        expect{reservation1.reload}.not_to raise_error
      end
      
      
      it 'returns a list of reservations within a range' do
        bookings = @booking.reserve_range(reserved_from: Date.today, reserved_until: 3.days.from_now, reservable: @room)
        expect(@booking.reservations.between(Date.tomorrow, 4.days.from_now)).to match bookings[1..3]
        
      end

      
    
    end
  end
end
