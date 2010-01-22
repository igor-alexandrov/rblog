class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 90.minutes
  end

# RBlog must be secure! So we allow mass-assignments only for these fields   
  attr_accessible :login, :email, :password, :password_confirmation

  named_scope :by_reputation, :order => "reputation DESC"

  def full_name
    self.last_name.to_s + " " + self.first_name.to_s + " " + self.middle_name.to_s
  end

  def short_name
    self.last_name.to_s + " " + self.first_name.to_s
  end


end
