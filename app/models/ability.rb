class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      case user.role.underscore.to_sym
        when :general
          can :create, Post
          can :edit, Post do |post|
            user == post.author
          end
          can :create, Comment do |comment|
            configatron.comments.user.use
          end
          can :change_rating_for, Post

        when :admin
          can :manage, :all
      end
    else
      # if "user" is "nil", it is a guest user.
      can :create, Comment do |comment|
        configatron.comments.guest.use
      end
    end
  end
end
