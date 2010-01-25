class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :parent_comment, :class_name => "Comment"

  belongs_to :author, :class_name => "User", :counter_cache => true

  has_many :comments, :class_name => "Comment", :foreign_key => "parent_comment_id", :primary_key => "id"

  validates_presence_of     :body

  def safe_parent_comment_id
    self.parent_comment_id ||= 0
  end


end
