# frozen_string_literal: true

class BarPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.booking.user == user
  end

  def update?
    true
  end

  class Scope < Scope
    def resolve
      scope.geocoded
    end
  end
end
