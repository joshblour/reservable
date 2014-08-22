require 'rails_helper'

module Reservable
  describe Reservation do
    
    before(:each) {@reservation = create(:reservation)}
    
    
    it 'has_many reservables' do
      expect(@reservation).to belong_to :reservable
    end
    
    it 'has_many reservers' do
      expect(@reservation).to belong_to :reserver
      
    end
          
    it 'raises errror if reservable is already reserved for that day' do      
      expect {
        create(:reservation, reservable: @reservation.reservable, reserved_on: @reservation.reserved_on)
      }.to raise_error ActiveRecord::RecordInvalid
    end
 
    it 'validates uniquness of reservable scoped by reserved_on' do
      expect(@reservation).to validate_uniqueness_of(:reserved_on).scoped_to(:reservable)
    end

  end  
end
