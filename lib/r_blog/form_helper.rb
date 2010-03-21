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
      %{<label class="b-form__label" for="#{field_name}">#{label}</label>} unless ["submit"].include?(type)
    end
    
    def self.legend(value)
      %{<small class="b-form__item_legend">#{value}</small>} unless value.nil?
    end
    
  end
end