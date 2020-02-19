# frozen_string_literal: true

class Bar < ApplicationRecord
  has_many :bookings
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, :address, presence: true # , uniqueness: true
  validates :price, :description, :capacity, :opening_start, :opening_end, presence: true
end
