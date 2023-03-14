# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.has_role? 'admin'
        can :manage, Inventory
        can :manage, Item
      else
        can :read, Inventory
        can :read, Item
      end
    else
      can :sign_up
    end
  end
end
