# frozen_string_literal: true

class BookingPolicy < ApplicationPolicy
  def show?
    [record.user, record.bar.owner].include?(user)
  end

  def create?
    true
  end

  def update?
    [record.user, record.bar.owner].include?(user)
  end

  def index?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
