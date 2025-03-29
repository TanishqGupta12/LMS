# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # Ensure `user` is present

    can :dashboard, :all
    can :access, :rails_admin
    can :history, :all
    can :read, :dashboard
    can :import, User

    if user.superadmin?
      can :manage, :all
      can :import, :all # Overrides previous restriction
    elsif user.admin?
      can :manage, :all
      cannot :manage, Role # Restrict role management for admins
    end
  end
end
