class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :bar, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.date :starts_at
      t.date :ends_at
      t.integer :guest_number
      t.string :state

      t.timestamps
    end
  end
end
