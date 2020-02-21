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

  DAY_NAME_TRANSLATIONS = {
    'Monday': 'Lundi',
    'Tuesday': 'Mardi',
    'Wednesday': 'Mercredi',
    'Thursday': 'Jeudi',
    'Friday': 'Vendredi',
    'Saturday': 'Samedi',
    'Sunday': 'Dimanche'
  }

  MONTH_NAME_TRANSLATIONS = {
    'January': 'Janvier',
    'February': 'Février',
    'March': 'Mars',
    'April': 'Avril',
    'May': 'Mai',
    'June': 'Juin',
    'July': 'Juillet',
    'August': 'Août',
    'September': 'Septembre',
    'October': 'Octobre',
    'November': 'Novembre',
    'December': 'Décembre'
  }

  def fr_day_name(en_day_name)
    DAY_NAME_TRANSLATIONS[en_day_name.to_sym]
  end

  def fr_month_name(en_month_name)
    MONTH_NAME_TRANSLATIONS[en_month_name.to_sym]
  end
end
