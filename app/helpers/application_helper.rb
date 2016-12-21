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

  def is_edit?
    params[:action] == 'edit'
  end

  def greeting
    if (times[:morning]..times[:noon]).cover? times[:now]
      "Good morning"
    elsif (times[:noon]..times[:evening]).cover? times[:now]
      "Good afternoon"
    elsif (times[:evening]..times[:night]).cover? times[:now]
      "Good evening"
    end
  end

  def personalised_message
    messages.sample
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  private

  def messages
    [
      'What have you baked today?',
      'What\'s cooking?',
      'Let\'s get baking!',
      'Anything tasty cooking?'
    ]
  end

  def times
    {
      now: Time.now,
      morning: Date.today.beginning_of_day,
      noon: Date.today.noon,
      evening: Date.today.to_time.change(hour: 17),
      night: Date.today.tomorrow
    }
  end
end
