class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      case user.role.underscore.to_sym
        when :general
          can :create, Post
          can :create, Comment

        when :admin
          can :manage, :all
      end
    else
    end
  end
end
