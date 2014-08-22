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
      def reserve options
        self.reservations.create(options)
      end
  
      def unreserve options
        reservations = self.reservations.where(options)
        reservations.destroy_all
      end
      
      def reserve_range options
        (options[:reserved_from].to_date..options[:reserved_until].to_date).map do |reserved_on|
          self.reservations.create(reserved_on: reserved_on, reservable: options[:reservable])
        end
      end
      
      def unreserve_range options  
        reservations = self.reservations.where(reservable: options[:reservable], reserved_on: options[:reserved_from].to_date..options[:reserved_until].to_date)
        reservations.destroy_all
      end
               
  
    end
  end
end
 
ActiveRecord::Base.send :include, Reservable::ActsAsReserver
