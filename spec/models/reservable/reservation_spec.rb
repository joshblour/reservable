require 'rails_helper'

module Reservable
  describe Reservation do
    
    before(:each) {@reservation = create(:reservation)}
    
    
    it 'has_many reservables' do
      expect(@room).to have_many :reservables
    end
    
    it 'has_many reservers' do
      expect(@room).to have_many :reservers
      
    end
          
    it 'raises errror if reservable is already reserved for that day' do      
      expect {
        create(:reservation, reservable: @reservation.reservable, reserve_on: @reservation.reserve_on)
      }.to raise_error ActiveRecord::RecordInvalid
    end
 
    it 'validates uniquness of reservable scoped by reserved_on' do
      expect(@reservation).to validate_uniqueness_of(:reservable).scoped_to(:reserved_on)
    end

  end  
end
