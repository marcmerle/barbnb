class NilObjectPolicy < ApplicationPolicy
  def owner_index?
    true
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
