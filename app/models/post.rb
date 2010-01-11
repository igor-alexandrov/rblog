class Post < ActiveRecord::Base
  has_many :comments

  belongs_to :category, :counter_cache => true
  belongs_to :author, :class_name => "User", :counter_cache => true
  
  acts_as_taggable_on :tags

  validates_presence_of :author

  validates_presence_of :title
  validates_length_of   :title, :minimum => 2

  validates_presence_of :body

  def to_param
    self.permalink
  end

  def first_level_comments
    Comment.find(:all, :conditions => {:post_id => self.id, :parent_comment_id => nil})
  end

  def comments_count
    self.comments.size
  end

  def title=(value)
    write_attribute :permalink, (value.transliterate_as_link)
    write_attribute :title, (value)
  end

  def add_comment(comment)
    comment = self.comments.build(comment)
    if comment.parent_comment_id.nil?
      comment.parent_comment_id = 0
    end
    comment
  end

end
