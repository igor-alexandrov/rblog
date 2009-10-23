require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/../wp_db.rb")
require File.expand_path(File.dirname(__FILE__) + "/../wp_post.rb")

namespace :migrate do
  desc "Basic migration from Wordpress engine"
  task(:from_wordpress => :environment) do
        
        wp_posts = WpPost.find(:all, :conditions => {:post_status => "publish", :post_type => "post"})
        for wp_post in wp_posts
          
          rblog_post = Post.new
          rblog_post.title = wp_post.post_title
          rblog_post.announcement = ""
          rblog_post.body = wp_post.post_content
          rblog_post.status = "published"
          rblog_post.created_at = wp_post.post_date
          rblog_post.updated_at = wp_post.post_modified
          
          rblog_post.save

          for wp_comment in wp_post.comments
            rblog_comment = Comment.new
            rblog_comment.post_id = wp_comment.comment_post_ID
            unless wp_comment.comment_parent.nil?
              rblog_comment.parent_comment_id = wp_comment.comment_parent
            else
              rblog_comment.parent_comment_id = 0
            end
            rblog_comment.commenter_name = wp_comment.comment_author
            rblog_comment.commenter_email = wp_comment.comment_author_email
            rblog_comment.body = wp_comment.comment_content
            rblog_comment.created_at = wp_comment.comment_date
            rblog_comment.updated_at = wp_comment.comment_date

            rblog_comment.post = rblog_post
            rblog_comment.save
          end
        end

  end
end
