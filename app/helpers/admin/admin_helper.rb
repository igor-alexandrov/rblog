module Admin::AdminHelper
  def treat_boolean_as_image(value, true_image, false_image)
    value ? tag(:img, {:src => true_image}) : "b"
  end
end