class AddCancelledByToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :cancelled_by, :int
  end
end
