class ChangeBookingDatesToTimestamps < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :starts_at, :datetime
    change_column :bookings, :ends_at, :datetime
  end
end
