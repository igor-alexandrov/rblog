class Category < ActiveRecord::Base
  has_many :posts

  def to_param
    self.permalink
  end
end