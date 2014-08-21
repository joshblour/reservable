module Reservable
  module ActsAsReserver
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def acts_as_reserver **options      
        include Reservable::ActsAsReserver::LocalInstanceMethods
        
        has_many :reservations, as: :reserver, class_name: 'Reservable::Reservation'
        has_many :reservables, as: :reservable, through: :reservations
        
      end

    end
    
    module LocalInstanceMethods
               
  
    end
  end
end
 
ActiveRecord::Base.send :include, Reservable::ActsAsReserver
