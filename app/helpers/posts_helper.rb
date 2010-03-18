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
    link_to post.category.title,
            category_path(post.category),
            {:class => "g-link-no-visited"}.merge(html_options) { |key, v1, v2| v1 + ' ' + v2 }
  end
  
  def edit_post_content_link(post, html_options = {})
    link_to "Edit this #{post.content.class.to_s.downcase}",
            edit_polymorphic_path([:posts, @post.content]),
            {:class => "b-post-edit_link g-link-no-visited"}.merge(html_options) { |key, v1, v2| v1 + ' ' + v2 }

  end
  
  def render_post_content(post)
    render :partial => "posts/#{post.content.class.to_s.downcase.pluralize}/show", :locals => {:content => post.content}
  end
  
  def render_post_preview(post)
    render :partial => "posts/preview", :locals => {:post => post}
  end
  
end
