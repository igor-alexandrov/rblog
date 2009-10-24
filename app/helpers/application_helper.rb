# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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
    path = "/" + page.permalink;
    for current_page in page.ancestors
      path = "/" + current_page.permalink + path
    end
    path
  end

  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

end
