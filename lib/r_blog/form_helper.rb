module RBlog
  module FormHelper   
    def self.wrapping(type, field_name, label, field, options = {})
      %{
      <div class="b-form__item">
        #{self.label(type, field_name, label)}
        #{field}
        #{self.legend(options[:legend])}
      </div>}
      
    end
    
    def self.label(type, field_name, label)
      label_class = []
      label_class << "b-form__label"
      label_class << "g-inline" if ["select", "date"].include?(type)
      %{<label class="#{label_class.join(' ')}" for="#{field_name}">#{label}</label>} unless ["submit", "error_messages"].include?(type)
    end
    
    def self.legend(value)
      %{<small class="b-form__item_legend">#{value}</small>} unless value.nil?
    end
    
  end
end