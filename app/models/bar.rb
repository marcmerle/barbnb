class Bar < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :opening_start, presence: true
  validates :opening_end, presence: true
end
