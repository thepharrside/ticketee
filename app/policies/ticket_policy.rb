class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.joins(:roles).where(roles: {user_id: user})
    end
    
  end  

    def show?
      user.try(:admin?) || record.project.has_member?(user)
    end

    def create?
      user.try(:admin?) || record.project.has_manager?(user) ||
      record.project.has_editor?(user)
    end

    def update?
      user.try(:admin?) || record.project.has_manager?(user) ||
        (record.project.has_editor?(user) && record.author == user)
    end

end

