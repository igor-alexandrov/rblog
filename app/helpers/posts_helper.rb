module PostsHelper
  def post_link(post, html_options = {})
      link_to post.title, post_path(post), html_options
  end
  
  def post_type_image(post, html_options = {})
    if File.exist?(RAILS_ROOT + "/public/images/posts/#{post.content_type.to_s.downcase}.png")
      image_tag "posts/#{post.content_type.to_s.downcase}.png",
                {:class => "b-bost__content_type_image"}.merge(html_options) { |key, v1, v2| v1 + ' ' + v2 }
    end
  end
  
  def post_category_link(post, html_options = {})
    cache category_path(post.category_id, :action_suffix => "post_title") do
      link_to post.category.title,
              category_path(post.category),
              {:class => "g-link-no-visited"}.merge(html_options) { |key, v1, v2| v1 + ' ' + v2 }
    end
  end
  
  def edit_post_content_link(post, html_options = {})
    if can? :edit, post
      link_to "Edit this #{post.content.class.to_s.downcase}",
              edit_polymorphic_path([:posts, @post.content]),
              {:class => "b-post-edit_link g-link-no-visited"}.merge(html_options) { |key, v1, v2| v1 + ' ' + v2 }
    end
  end
  
  def new_post_comment_link(post, name, title = nil, parent_comment_id = 0, parent_comment_depth = 0)
    title = name if title.nil?
    if can? :create, Comment.new(:depth => parent_comment_depth)
      link_to_remote content_tag(:span, name, :class => "g-javascript_link__value"),
                          {:url => { :controller => "comments", :action => "new", :post_id => post.id,
                                      :parent_comment_id => parent_comment_id}, :method => "get", },
                                      :href => new_post_comment_url(post.id, :anchor => "new_comment"),
                                      :class => "g-javascript_link",
                                      :title => title
    end
  end
  
  def render_post_content(post)
    render :partial => "posts/#{post.content.class.to_s.downcase.pluralize}/show", :locals => {:content => post.content}
  end
  
  def render_post_preview(post)
    render :partial => "posts/preview", :locals => {:post => post}
  end
  
  def render_post_details(post, options = {})
    render :partial => "posts/post_details", :locals => { :post => post, :options => options }
  end
  
  def render_post_comments(post, parent_comment_id = 0, html_options = {})
    content_tag(:ul, :id => "comment_#{parent_comment_id}_children", :class => "b-post__comments_list") do
      render :partial => "comments/show", :collection => @comments.select { |comment| comment.parent_comment_id == parent_comment_id }, :as => :comment
    end
  end
  
end
