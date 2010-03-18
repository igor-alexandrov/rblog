class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :parent_comment, :class_name => "Comment"

  belongs_to :author, :class_name => "User", :counter_cache => true

  has_many :comments, :class_name => "Comment", :foreign_key => "parent_comment_id", :primary_key => "id"

  validates_presence_of     :body

  def initialise(params = nil)
    super
    self.depth = 0 unless self.depth
  end

  def parent_comment_id
    read_attribute(:parent_comment_id).nil? ? 0 : read_attribute(:parent_comment_id)
  end

  def parent_comment_depth
    self.parent_comment.nil? ? 0 : self.parent_comment.depth 
  end

  def parent_comment=(value)
    write_attribute :parent_comment_id, (value.id)
    write_attribute :depth, (value.depth+1)
  end
  
end
