class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      case user.role.underscore.to_sym
        when :general
          can :create, Post
          can :edit, Post
          can :create, Comment
          can :change_rating_for, Post

        when :admin
          can :manage, :all
      end
    else
    end
  end
end
