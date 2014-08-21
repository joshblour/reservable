require 'rails_helper'

module Reservable

  
  describe ActsAsReserver do
    context '.acts_as_reserver' do
      before(:each) {@booking = create(:booking)}
      
      it 'responds' do
        expect(Booking).to respond_to :acts_as_reserver
      end
      
      it 'has_many reservations' do
        expect(@booking).to have_many :reservations
      end
      
      it 'has_many reservables through holdings' do
        expect(@booking).to have_many :reservables
        
      end

      it 'adds a reservation for a specific reservable' do
        pending
        
      end
      
      it 'removes a reservation for a specific reservable' do
        pending
        
      end
      
      it 'adds a range of reservations for a single reservable/resource' do
        pending
        
      end
      
      it 'removes a range of reservations for a single reservable/resource' do
        pending
        
      end
      
      it 'returns a list of reservations within a range' do
        pending
        
      end

      
    
    end
  end
end
