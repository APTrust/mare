class Ability
  include CanCan::Ability

  # All users can manage their profile but not change their role or institution.
  #
  # Superuser:
  # * Can create, read and update everything
  # * Can delete Users
  # * Are the only class that can create superusers
  # * Are the only class tha can change instuttional affiliation
  #
  # Institutional Admin:
  # * Can crud any user from their Institution
  # * Can change role for any user from their Institution
  # * Cannot change Institution for any user
  # * Cannot create superusers
  # * Can read and update information for their Institution.
  # * Can create, read and update a DescriptionObject, Bag, CompressedBag or Transactional Object owned by their Institution.
  # * Cannot delete a DescriptionObject, Bag, CompressedBag or Transactional Object owned by their Institution.
  #
  # Institutional User:
  # * Can read any object owned by their Institution.
  #
  # Any authenticated user:
  # * Can update their own User profile
  # 
  # Unauthenticated users:
  # * Denied access to all parts of the application
  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    # Unauthenticaed users
    cannot :manage, :all

    # Any authenticated users
    if user
      can [:read, :update], User, id: user.id
      cannot :manage_role, User
      cannot :assign_superuser, User
      cannot :manage_institution, User
      cannot :destroy, User
    end

    # Superuser
    if user.is? :superuser
      can [:create, :read, :update], :all
      can :assign_superuser, User
      can :manage_institution, User
      can :manage_role, User
      can :destroy, User
    end

    # Institutional Admin
    if user.is? :institutional_admin
      can [:crud, :manage_role], User, institution_id: user.institution_id
      cannot [:manage_institution, :assign_superuser], User

      can [:read, :update], Institution, id: user.institution.id
      can [:create, :read, :update], DescriptionObject, institution_id: user.institution.id
      can [:create, :read, :update], Bag, institution_id: user.institution.id
      can [:create, :read, :update], CompressedBag, institution_id: user.institution.id
      can [:create, :read, :update], TransactionalObject, institution_id: user.institution.id
    end

    # Institutional Guest
    if user.is? :institutional_user
      can :read, Institution, id: user.institution.id
      can :read, DescriptionObject, institution_id: user.institution.id
      can :read, Bag, institution_id: user.institution.id
      can :read, CompressedBag, institution_id: user.institution.id
      can :read, TransactionalObject, institution_id: user.institution.id
    end
  end
end
