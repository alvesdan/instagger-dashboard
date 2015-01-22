module ApplicationHelper

  def fancy_pluralize(number, word, plural = nil)
    count, counted = pluralize(number, word, plural).split(' ', 2)
    [
      content_tag(:span, count, class: 'count'),
      content_tag(:span, counted, class: 'counted')
    ].join(' ').html_safe
  end

  def icon_tag(key)
    content_tag :span, nil, class: ['glyphicon', "glyphicon-#{key}"]
  end
end
