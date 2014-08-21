module Reservable
  class Reservation < ActiveRecord::Base
    belongs_to :reservable, polymorphic: true
    belongs_to :reserver, polymorphic: true
    
    validates :reserved_on, uniqueness: {scope: :reservable}
    
    # scope :self_join, -> {joins('INNER JOIN reservable_reservations t2 ON t2.reservable_id = t1.reservable_id AND t2.reservable_type = t1.reservable_type').from('reservable_reservations t1').select('t1.*')}
    scope :between, -> (from, to) {where('reserved_on BETWEEN :from and :to', from: from, to: to)}
    # scope :consecutive, -> {where('NOT EXISTS (SELECT 1 FROM reservable_reservations t3 WHERE t3.reservable_id = t1.reservable_id AND t3.reservable_type = t1.reservable_type AND t3.reserved_on BETWEEN t2.reserved_on and t1.reserved_on)')}
    scope :with_interval, -> {select('*, reserved_on - (lag(reserved_on) over (partition by reservable_type, reservable_id order by reserved_on)) - 1 as interval')}
    scope :invervals_between, -> (from, to, days) {select('reservable_type, reservable_id').from(self.with_interval.between(from, to)).where('(interval >= :days)',from: from, to: to, days: days)}
    scope :edges_between, ->(from, to, days) {select(:reservable_type, :reservable_id).group(:reservable_type, :reservable_id).having('(max(reserved_on) < :to) OR (min(reserved_on) > :from)', from: from + days, to: to - days )}
  end
end
