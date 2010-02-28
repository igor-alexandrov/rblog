class PostsSweeper < ActionController::Caching::Sweeper      
  observe Post

  def after_update(post)
    expire_cache_for(post)
  end

  private
  def expire_cache_for(record)        
    expire_fragment post_path(record.id, :action_suffix => "preview")
    expire_fragment post_path(record.id, :action_suffix => "tags")
    expire_fragment post_path(record.id, :action_suffix => "author")
  end
end
