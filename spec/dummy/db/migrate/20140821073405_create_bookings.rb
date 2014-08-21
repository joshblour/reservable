class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :title
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
