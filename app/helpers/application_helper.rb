# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_date(date)
    date.strftime("%d, %B %Y, %H:%M")
  end

  def pagination_for(items)
    will_paginate items, :previous_label =>"← previous", :next_label => "next →", :renderer => WillPaginate::RBlogLinkRenderer
  end

# tools for easily link creation 
  def twitter_url_for_post( post )
    "http://twitter.com/home/?status=#{post_short_url(post.id)} #{post.title}"
  end

  def link_to_twitter( post, title = "" )
    link_to image_tag("/images/twitter.png", :title => title,  :class => "b-bost__twitter_image"),  twitter_url_for_post(post), :target => "_blank"
  end

  def delicious_url_for_post( post )
    "http://delicious.com/save?&url=#{post_short_url(post.id)}&title=#{post.title}"
  end

  def link_to_delicious( post, title = "" )
    link_to image_tag("/images/delicious.png", :title => title,  :class => "b-bost__delicious_image"), delicious_url_for_post(post), :target => "_blank"
  end

  def digg_url_for_post( post )
    "http://digg.com/submit?&url=#{post_short_url(post.id)}&title=#{post.title}"
  end

  def link_to_digg( post, title = "" )
    link_to image_tag("/images/digg.png", :title => title,  :class => "b-bost__digg_image"), digg_url_for_post(post), :target => "_blank"
  end


  def display_tree_recursive(tree, parent_id = nil, options = {})
    #content_tag(:ul, :id => "comment_#{parent_id}_children" ) do
    tree.inject('') do |output, node|
      output = output + (if node.parent_comment_id == parent_id
        content_tag(:li, options[:li_options] || {}) do

          (render :partial => "comments/show", :locals => {:comment => node}) + (node.comments.empty? ? display_tree_recursive(tree, node.id) :
                  display_tree_recursive(tree, node.id))


        end

      end || '')

    end
    #end
  end

  def page_path(page)
    url = '/pages'
    for current_page in page.ancestors.reverse
      url = url + "/" + current_page.permalink
    end
    url + "/" + page.permalink
  end

  def title(page_title = "", show_title = true)
    @content_for_title = ""
    (@content_for_title = " ‒ " + page_title.to_s) unless page_title.to_s.blank?
    @content_for_title = (configatron.general.blog_title + @content_for_title)
    @show_title = show_title
  end


  def content_menu( options = {} )
    content_for(:content_menu, render( :partial => "shared/menu", :locals => {:options => options} ))
  end

  def post_type_menu( options = {} )
    content_for(:post_type_menu, render( :partial => "shared/post_type_menu", :locals => {:options => options} ))
  end

  def heading_h1( value )
    content_for(:heading_h1, value)
  end

  def edit_posts_content_path(content)
    eval("edit_posts_#{content.class.to_s.downcase}_path(content)")
  end

end
