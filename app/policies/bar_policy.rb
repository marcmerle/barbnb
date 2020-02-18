# frozen_string_literal: true

class BarPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.owner == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
