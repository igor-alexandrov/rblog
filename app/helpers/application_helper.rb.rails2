# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_date(date)
    content_tag :span, :class => 'date' do
      date.strftime("%d %B, %Y %H:%M")
    end
  end

  def pagination_for(items)
    will_paginate items, :previous_label =>"← previous", :next_label => "next →", :renderer => WillPaginate::RBlogLinkRenderer
  end

  def commit_link(name, commit_id)
    link_to name, "http://github.com/igor-alexandrov/rblog/commit/" + commit_id
  end

  def commit_information(commit_id)
    repo = Octopi::Repository.find(:user => "igor-alexandrov", :repo => "rblog")
    if repo.commits.first.id == commit_id
      information = content_tag(:div, :class => 'version-message latest-commited') do
        %{
          <h3>You are using the latest commited version of RBlog</h3>
          <p>You should understand, that the latest commited version has the freshest features, but it is not always the most stable.
          We don't recommend you to use this version in production, unless you know what you are doing.</p>
        }
      end
    elsif (tags = repo.tags.select{|tag| tag.sha == commit_id}).empty?
      information = content_tag(:div, :class => 'version-message outdated') do
        %{
          <h3>Your Rblog version is outdated</h3>
          <p>Your version is not tagged and not latest commited. Please update as soon as possible.</p>
          <p><b>Don't forget to backup all your data before updating.</b></p>
        }
      end
    elsif !tags.empty?
      information = content_tag(:div, :class => 'version-message tagged') do
        %{
          <h3>Your Rblog version is tagged as '#{tags.first.name}'</h3>
          <p>If you want to update, visit our GitHub page and find the latest tag.</p>
          <p><b>Don't forget to backup all your data before updating.</b></p>
        }
      end
    end
    content_tag(:div, information, :class => 'b-commit-information')
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
