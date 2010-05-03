module TagsHelper
  def tag_link(tag, options = {})
    link_to tag.name, posts_tag_path(tag),
      { :class => "tag", 
        :rel => 'tag',
        :title => "see all posts tagged with ‹‹#{tag.name}››" }.merge(options) { |key, v1, v2| v1 + ' ' + v2
          }
  end
end