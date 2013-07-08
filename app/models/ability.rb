class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Conference, owner_id: user.id
      can :manage, ConferenceEdition, conference: { owner_id: user.id }
    elsif user.superadmin?
      can :manage, :all
    end
  end
end
