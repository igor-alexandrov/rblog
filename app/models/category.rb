class Category < ActiveRecord::Base
  has_many :posts

  def after_initialize 
    return unless new_record?
    self.posts_count = 0
  end

  def to_param
    self.permalink
  end
end