class WpComment < WpDb
  belongs_to :wp_post
  belongs_to :comment_parent, :class_name => "WpComment"
  has_many :comments, :class_name => "WpComment", :foreign_key => "comment_parent", :primary_key => "comment_ID"

  set_primary_key "comment_ID"

  def self.table_name
    "wp_comments"
  end

end