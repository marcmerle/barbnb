class Booking < ApplicationRecord
  belongs_to :bar
  belongs_to :user

  validates: :amout, :starts_at, :ends_at, :state, :guest_number, presence: true
end
