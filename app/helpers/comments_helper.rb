module CommentsHelper
  def comment_author_link(comment, html_options = {})
    link_to comment.author.login, user_path(comment.author.login)
  end
  
  def comment_permalink_link(comment, name = "#", title = nil, html_options = {})
    title = "direct link to this comment" if title.nil?
    link_to name, "#comment_#{comment.id}", :title => title
  end
  
  def comment_parent_permalink_link(comment, name = "#", title = nil, html_options = {})
    title = "direct link to this comment" if title.nil?
    unless comment.parent_comment_id == 0
        link_to '↑', "#comment_#{comment.parent_comment_id}", :title => "direct link to parent comment"
    end
  end
  
  def render_comment_details(comment, options = {})
    render :partial => "comments/#{comment.class.to_s.underscore}_details", :locals => {:comment => comment}
  end
end
