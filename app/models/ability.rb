class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Conference, owner_id: user.id
      can :manage, ConferenceEdition, conference: { owner_id: user.id }
      can :manage, Image, conference: { owner_id: user.id }
      can :manage, Post, conference: { owner_id: user.id }
      can :manage, Slot, conference: { owner_id: user.id }
      can :manage, Speaker, conference: { owner_id: user.id }
      can :manage, Sponsor, conference: { owner_id: user.id }
      can :manage, Subscriber, conference: { owner_id: user.id }
      can :manage, Talk, conference: { owner_id: user.id }
    elsif user.superadmin?
      can :manage, :all
    end
  end
end
