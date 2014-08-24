module Reservable
  class Reservation < ActiveRecord::Base
    belongs_to :reservable, polymorphic: true
    belongs_to :reserver, polymorphic: true
    
    validates :reserved_on, uniqueness: {scope: :reservable}
    
    scope :between, -> (from, to) {where('reserved_on BETWEEN :from and :to', from: from.to_date, to: to.to_date)}
    scope :with_interval, -> {select('*, reserved_on - (lag(reserved_on) over (partition by reservable_type, reservable_id order by reserved_on)) - 1 as interval')}
    scope :invervals_between, -> (from, to, days) {select('reservable_type, reservable_id').from(self.with_interval.between(from, to)).where('(interval >= :days)',from: from.to_date, to: to.to_date, days: days.to_i)}
    scope :edges_between, ->(from, to, days) {select(:reservable_type, :reservable_id).group(:reservable_type, :reservable_id).having('(max(reserved_on) < :to) OR (min(reserved_on) > :from)', from: from.to_date + days.to_i, to: to.to_date - days.to_i )}
  end
end
