# frozen_string_literal: true

class Bar < ApplicationRecord
  has_many :bookings, dependent: :nullify
  has_many :reviews, dependent: :destroy
  belongs_to :owner, inverse_of: :bars, class_name: "User", foreign_key: "user_id"
  has_many_attached :photos

  validates :name, :address, presence: true, uniqueness: true
  validates :price, :description, :capacity, :opening_start, :opening_end, presence: true
end
