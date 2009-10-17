class Post < ActiveRecord::Base
    has_many :comments

    def first_level_comments
        Comment.find(:all, :conditions => {:post_id => self.id, :parent_comment_id => nil})
    end

    def comments_count
        self.comments.size
    end
end
