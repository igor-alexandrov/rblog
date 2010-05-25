module SidebarHelper
  def show_tag_cloud!
    tags = Post.tag_counts_on(:tags)
    content_for :sidebar do
      content_tag :div, :class => 'sbar-item' do
        render :partial => "shared/sidebar/tag_cloud", :locals => {:tags => tags}
      end
    end
  end
end