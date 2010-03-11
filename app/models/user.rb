class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 90.minutes
# Validate minimal length of password
    unless configatron.users.password_minimal_length.nil?
      c.merge_validates_length_of_password_field_options :minimum => configatron.users.password_minimal_length, :if => :require_password?
    end
  end

# Setup gravatar.com service 
  is_gravtastic! :email,
                 :filetype => :png,
                 :size => 60

# Validate presence of mandatory attributes
  unless configatron.users.mandatory_attributes.nil?
    configatron.users.mandatory_attributes.each do |attribute|
      validates_presence_of attribute
    end
  end

# RBlog must be secure! So we allow mass-assignments only for these fields
  attr_accessible :login, :email, :password, :password_confirmation

  named_scope :by_reputation, :order => "reputation DESC"

  has_many :favourites, :class_name => "Favourite"

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
end
