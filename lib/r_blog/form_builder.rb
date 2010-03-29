module RBlog
  class FormBuilder < ActionView::Helpers::FormBuilder
    def field_settings(method, options = {}, tag_value = nil)
      field_name = "#{@object_name}_#{method.to_s}"
      label = options[:label].nil? ? "#{method.to_s.gsub(/\_/, " ").humanize}" : options[:label]
      
      # options[:class] += options[:required] ? " required" : ""
      label += "<strong><sup>*</sup></strong>" if options[:required]
      [field_name, label, options]
    end
    
    def text_field(method, options = {})
      field_name, label, options = field_settings(method, options)
      options[:class] ||= "b-form__input-text"
      RBlog::FormHelper.wrapping("text", field_name, label, super, options)
    end
    
    def submit(method, options = {})
      field_name, label, options = field_settings(method, options)
      options[:class] ||= "b-form__input-submit"
      RBlog::FormHelper.wrapping("submit", field_name, label, super, options)
    end
    
  end
end