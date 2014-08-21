class CreateReservableReservations < ActiveRecord::Migration
  def change
    create_table :reservable_reservations do |t|
      t.string :reservable_type
      t.integer :reservable_id
      t.string :reason
      t.string :category
      t.date :reserved_on
      t.string :reserver_type
      t.integer :reserver_id

      t.timestamps
    end
  end
end
