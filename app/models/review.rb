# frozen_string_literal: true

#
## Review Model
## A Restaurant has many reviews (Comments + Rating)
class Review < ApplicationRecord
  belongs_to :bar

  validates :content, :rating, presence: true
  validates :rating, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
end
