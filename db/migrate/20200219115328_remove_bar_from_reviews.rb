# frozen_string_literal: true

class RemoveBarFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :bar, index: true, foreign_key: true
    add_reference :reviews, :booking, index: true, foreign_key: true
  end
end
