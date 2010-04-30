class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 90.minutes
    c.login_field = 'email'
    c.validate_login_field = false
    
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    
    unless configatron.users.password_minimal_length.nil?
      c.merge_validates_length_of_password_field_options :minimum => configatron.users.password_minimal_length, :if => :require_password?
      c.validates_length_of_password_field_options = {:on => :update, :minimum => configatron.users.password_minimal_length, :if => :has_no_credentials?}
      c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => configatron.users.password_minimal_length, :if => :has_no_credentials?}
    end
  end

# Setup gravatar.com service 
  is_gravtastic! :email,
                 :filetype => :png,
                 :size => 60

# Validate presence of mandatory attributes
  unless configatron.users.mandatory_attributes.nil?
    configatron.users.mandatory_attributes.each do |attribute|
      validates_presence_of attribute, :on => :update
    end
  end

# RBlog must be secure! So we allow mass-assignments only for these fields
  attr_accessible :first_name, :last_name, :gender, :date_of_birth

  scope :by_reputation, :order => "reputation DESC"

  has_many :favourites, :class_name => "Favourite", :dependent => :destroy
  
  has_many  :social_connections,
            :dependent => :destroy,
            :finder_sql => 
    'SELECT sc.*, scp.name, scp.prefix, scp.suffix FROM social_connections sc LEFT JOIN social_connection_patterns scp
    ON sc.pattern_id = scp.id WHERE sc.user_id = #{self.id}'

  def self.genders
    ["female", "male"]
  end
  
  def after_initialize 
    return unless new_record?
    self.role = "GENERAL" unless self.role
  end

  def has_no_credentials?
    self.crypted_password.blank?# && self.openid_identifier.blank?
  end
  
  def signup!(params)
    self.email = params[:user][:email]
    self.save_without_session_maintenance
  end

  def full_name
    self.last_name.to_s + " " + self.first_name.to_s + " " + self.middle_name.to_s
  end

  def short_name
    self.last_name.to_s + " " + self.first_name.to_s
  end

  def avatar
    self.gravatar_url
  end

  def screen_name
    self.username
  end
  
  def active?
    self.active
  end
  
  def activate!(params)    
    password = params["user"].delete("password")
    password_confirmation = params["user"].delete("password_confirmation")
    username = params["user"].delete("username")
   
    self.password = password
    self.password_confirmation = password_confirmation
    self.username = username
   
    self.attributes = params[:user]
    self.active = true

    self.save
  end

  def deliver_activation_instructions!
    # reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end

  def deliver_activation_confirmation!
    # reset_perishable_token!
    Notifier.activation_confirmation(self).deliver
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
      self.relreased_at = DateTime.now
      self.save!
    end
  end

  def has_favourite?(object)
     Rails.cache.fetch("users/#{self.id}/favourites/#{object.class.to_s.pluralize.downcase}/#{object.id}") {
      !Favourite.find( :first, :conditions => {:user_id => self.id, :object_type => object.class.to_s, :object_id => object.id} ).nil?
     }
  end

  def add_favourite!(object)
    Favourite.create do |f|
      f.object_id = object.id
      f.object_type = object.class.to_s
      f.user_id = self.id
    end
  end

  def remove_favourite!(object)
    begin
      Rails.cache.delete("users/#{self.id}/favourites/#{object.class.to_s.pluralize.downcase}/#{object.id}")
    ensure
      Favourite.find( :first, :conditions => {:user_id => self.id, :object_type => object.class.to_s, :object_id => object.id} ).destroy
    end
  end
  
  def add_social_connection!(social_connection_pattern, value)
    SocialConnection.create(:pattern => social_connection_pattern, :user => self, :value => value)
  end
end
