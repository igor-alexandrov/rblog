class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :parent_comment, :class_name => "Comment"
  has_many :comments, :class_name => "Comment", :foreign_key => "parent_comment_id", :primary_key => "id"
end
