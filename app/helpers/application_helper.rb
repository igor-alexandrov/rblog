# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def display_tree_recursive(tree, parent_id = nil, options = {})
        content_tag(:ul, options[:ul_options] || {}) do
            tree.inject('') do |output, node|
                output + (if node.parent_comment_id == parent_id
                        content_tag(:li, options[:li_options] || {}) do
                            (render :partial => "comments/show", :locals => {:comment => node}) + (node.comments.empty? ? '' :
                                  display_tree_recursive(tree, node.id))
                        end
                    end || '')
            end
        end
    end
end
