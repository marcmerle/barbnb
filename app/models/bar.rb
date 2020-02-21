# frozen_string_literal: true

class Bar < ApplicationRecord
  include PgSearch::Model
  has_many :bookings, dependent: :nullify
  has_many :reviews, through: :bookings
  belongs_to :owner, inverse_of: :bars, class_name: "User", foreign_key: "user_id"
  has_many_attached :photos
  geocoded_by :address

  pg_search_scope :bar_search,
                  against: %i[name address],
                  using: {
                    tsearch: { prefix: true }
                  }

  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, :address, presence: true # , uniqueness: true
  validates :price, :description, :capacity, :opening_start, :opening_end, presence: true

  attr_accessor :distance

  def average_review
    reviews.empty? ? nil : (reviews.map(&:rating).sum / reviews.size).round
  end
end
