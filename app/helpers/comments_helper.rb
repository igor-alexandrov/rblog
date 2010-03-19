module CommentsHelper
  def render_comment_details(comment, options = {})
    render :partial => "comments/#{comment.class.to_s.underscore}_details", :locals => {:comment => comment}
  end
end
