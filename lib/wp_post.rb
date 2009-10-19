class WpPost < WpDb
  has_many :comments, :class_name => "WpComment", :foreign_key => "comment_post_ID", :primary_key => "ID"

  set_primary_key "ID"

  def self.table_name
    "wp_posts"
  end

end