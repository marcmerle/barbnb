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

  DATE_TRANSLATIONS = {
    'Monday': 'Lundi',
    'Tuesday': 'Mardi',
    'Wednesday': 'Mercredi',
    'Thursday': 'Jeudi',
    'Friday': 'Vendredi',
    'Saturday': 'Samedi',
    'Sunday': 'Dimanche',
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

  def date_in_french
    string = starts_at.in_time_zone("CET").strftime("Le %A %d  %B, de %Hh%M à ")
    string += ends_at.in_time_zone("CET").strftime("%Hh%M")
    DATE_TRANSLATIONS.each { |en, fr| string.gsub!(Regexp.quote(en), fr) }

    return string
  end
end
