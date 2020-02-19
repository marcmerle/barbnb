# frozen_string_literal: true

##
# Booking Model
# Has a bar to book by a user
# The booking takes place during some time, for a certain number of attendees at a certain price
class Booking < ApplicationRecord
  belongs_to :bar
  belongs_to :user
  has_one :review, dependent: :nullify

  validates :amount, :starts_at, :ends_at, :state, :guest_number, presence: true
end
