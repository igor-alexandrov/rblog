module WillPaginate
  class RBlogLinkRenderer < WillPaginate::LinkRenderer
    def to_html
      links = @options[:page_links] ? windowed_links : []
      # previous/next buttons
      buttons = []
      buttons.push   button_link_or_span(@collection.previous_page, 'disabled previous', @options[:previous_label])
      buttons.push   button_link_or_span(@collection.next_page,     'disabled next', @options[:next_label])


      @template.content_tag :div, :class => 'b-pagination' do
        @template.content_tag(:div, buttons.join(@options[:separator]), :class => 'b-pagination__buttons') +
        @template.content_tag(:div, links.join(@options[:separator]), :class => 'b-pagination__pages')
      end
    end

    protected
    def page_link_or_span(page, span_class, text = nil)
      text ||= page.to_s

      if page and page != current_page
        classnames = span_class && span_class.index(' ') && span_class.split(' ', 2).last
        page_span page, text, :rel => rel_value(page), :class => classnames
      else
        current_page_span page, text
      end
    end

    def button_link_or_span(page, span_class, text = nil)
      text ||= page.to_s

      if page and page != current_page
        classnames = span_class && span_class.index(' ') && span_class.split(' ', 2).last
        button_link page, text, :rel => rel_value(page), :class => classnames
      else
        current_button_span page, text
      end
    end

    def page_span(page, text, attributes = {})
      @template.content_tag :span, :class => 'page' do
        @template.link_to text, url_for(page)
      end
    end

    def current_page_span(page, text)
      @template.content_tag :span, text, :class => 'page current'
    end

    def button_link(page, text, attributes = {})
      @template.link_to text, url_for(page)
    end
    
    def current_button_span(page, text)
      @template.content_tag :span, text, :class => 'current'
    end

  end
end