# frozen_string_literal: true

##
# Bar model
# Definition and instance methods
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
  validates :price, :description, :capacity, :opening_start, :opening_end, :photos, presence: true

  attr_accessor :distance

  def average_rating
    reviews.empty? ? nil : reviews.map(&:rating).sum.fdiv(reviews.size).round(2)
  end
end

##
# Bar model
# Class methods
class Bar
  # Sorting Method
  # But the bars with active bookings first, then the others, ordered alphabetically
  # Bars with active bookings are ordered by the earliest booking
  def self.sort_by_bookings(bar_list = Bar.all)
    return [] if bar_list.blank?

    bars_with_active_bookings = bar_list.select { |bar| bar.bookings.where(state: "À venir").any? }
                                        .sort_by do |bar|
      bar.bookings.where(state: "À venir")
         .order(:starts_at)
         .limit(1).first.starts_at.to_i
    end

    bars_without_active_bookings = bar_list.reject { |bar| bar.bookings.where(state: "À venir").any? }
                                           .sort_by(&:name)

    [bars_with_active_bookings, bars_without_active_bookings].flatten
  end
end
