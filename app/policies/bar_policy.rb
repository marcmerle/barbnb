class BarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end