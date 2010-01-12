class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :parent_comment, :class_name => "Comment"

  belongs_to :author, :class_name => "User", :counter_cache => true

  has_many :comments, :class_name => "Comment", :foreign_key => "parent_comment_id", :primary_key => "id"

  validates_presence_of     :body

  validates_presence_of     :commenter_name

  validates_presence_of     :commenter_email
  validates_length_of       :commenter_email,    :within => 6..100
  validates_format_of       :commenter_email,    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
