class PagesSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_update(page)
    expire_cache_for(page)
  end

  private
  def expire_cache_for(record)
    expire_fragment :controller => :header, :action => :main_menu
    expire_fragment :controller => :pages, :id => record.id, :action => :show, :action_suffix => :children   
  end
end 
