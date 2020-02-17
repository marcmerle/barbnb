# frozen_string_literal: true

class Bar < ApplicationRecord
  has_many :bookings
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  validates :name, :address, presence: true, uniqueness: true
  validates :price, :description, :capacity, :opening_start, :opening_end, presence: true
end
