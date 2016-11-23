module ApplicationHelper
  def error_div_with content=nil, &block
    content_tag(:div, class: 'form-error') do
      content_tag(:span, content, nil, &block)
    end
  end
  
  def error_for klass, attribute
    return nil unless klass && klass.errors[attribute].present?

    error_div_with klass.errors[attribute].first
  end
end
