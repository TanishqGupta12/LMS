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
      can :manage, Category , event_id: user.current_event_id.to_i
    elsif user.admin?
      can :manage, :all
      cannot :manage, Role # Restrict role management for admins
    elsif user.teacher?
      can :read, Category
      can :read, User
      can :manage ,Blog ,user_id: user.id , event_id: user.current_event_id.to_i
      can :manage, Ticket ,user_id: user.id , event_id: user.current_event_id.to_i
      # Allow teacher to manage courses where teacher_id and event_id match
      can :manage, Course, teacher_id: user.id, event_id: user.current_event_id.to_i
    end
  end
end
