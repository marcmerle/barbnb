class Bar < ApplicationRecord
  has_many :bookings
  belongs_to :user

  validates :name, :address, presence: true, uniqueness: true
  validates :price, :description, :capacity, :opening_start, :opening_end, presence: true
end
