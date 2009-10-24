class PagesController < ApplicationController
  def show
    if params[:href]
      current_level_pages = Page.roots
      for permalink in params[:href]
        @page = current_level_pages.detect { |item| item.permalink == permalink }
        raise ActiveRecord::RecordNotFound, 'Запрашивая вами страница не найдена' if @page.nil?
        current_level_pages = @page.children
      end
    else
      @page = Page.find(params[:id])
    end
    
  end
end