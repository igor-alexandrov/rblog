class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 90.minutes
  end

  is_gravtastic! :email,
                 :filetype => :png,
                 :size => 60
  
#  Validate presence of mandatory attributes
  unless configatron.users.mandatory_attributes.nil?    
    configatron.users.mandatory_attributes.each do |attribute|
      validates_presence_of attribute
    end    
  end
  
#  Validate minimal length of password
  unless configatron.users.password_minimal_length.nil?
    validates_length_of :password, :minimum => configatron.users.password_minimal_length
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

  def avatar
    self.gravatar_url
  end

  def admin?
    self.role == "ADMIN"
  end

  def blocked?
    !self.blocked_at.nil?
  end
  
  def block!
    unless self.blocked?
      self.released_at = nil
      self.blocked_at = DateTime.now
      self.save!
    end
  end
  
  def release!
    if self.blocked?
      self.blocked_at = nil
      self.released_at = DateTime.now
      self.save!
    end
  end
  
end
