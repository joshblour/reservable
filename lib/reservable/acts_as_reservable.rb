module Reservable
  module ActsAsReservable
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def acts_as_reservable **options      
        include Reservable::ActsAsReservable::LocalInstanceMethods
        
        has_many :reservations, as: :reservable, class_name: 'Reservable::Reservation'
        has_many :reservers, as: :reserver, through: :reservations
                
        accepts_nested_attributes_for :reservations, allow_destroy: true
      end
      
      
      def find_available(from, to, days)
        interval_ids = Reservable::Reservation.invervals_between(from, to, days).where('reservable_type = :class', class: self.name).map(&:reservable_id)
        edge_ids = Reservable::Reservation.edges_between(from, to, days).where('reservable_type = :class', class: self.name).map(&:reservable_id)
        missing_ids = self.includes(:reservations).where.not('reservable_reservations.reserved_on BETWEEN :from and :to', from: from, to: to).references(:reservations).pluck(:id)
        self.where(id: interval_ids + edge_ids + missing_ids)
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
          self.reservations.create(reserved_on: reserved_on, reserver: options[:reserver])
        end
      end
      
      def unreserve_range options  
        reservations = self.reservations.where(reserved_on: options[:reserved_from]..options[:reserved_until])
        reservations.destroy_all
      end
    end
  end
end
 
ActiveRecord::Base.send :include, Reservable::ActsAsReservable
