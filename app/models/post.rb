class Post < ActiveRecord::Base
  has_many :comments

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
