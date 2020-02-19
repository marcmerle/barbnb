# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy
  def create
    record.booking.user == user
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
