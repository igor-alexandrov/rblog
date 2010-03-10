class PagesSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_update(post)
    expire_cache_for(post)
  end

  private
  def expire_cache_for(record)
    expire_fragment :controller => :header, :action => :main_menu
    expire_fragment :controller => :pages, :id => @page.id, :action => :show, :action_suffix => :children   
  end
end 
