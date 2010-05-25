class InternalMessage < ActiveRecord::Base
  has_one :user, :as => :sender
  has_one :user, :as => :recipient

  named_scope :received, lambda { |user| { :conditions => { :recipient_id => user.id } } }
  named_scope :unread, lambda { |user| { :conditions => { :recipient_id => user.id, :read_at => nil } } }
  named_scope :sent, lambda { |user| { :conditions => { :sender_id => user.id } } }

  def read!
    self.read_at = DateTime.now
    self.first_time_read_at = DateTime.now if self.first_time_read_at == nil
    self.save!
  end

  def unread!
    self.read_at = nil
    self.save!
  end

end
