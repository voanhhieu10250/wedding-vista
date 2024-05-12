ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  # def format_error_message_to_html_list(instance)
  #   messages = [*instance.error_message].map { |msg| "<li>#{msg}</li>" }
  #   return unless messages.present?

  #   "<div class='invalid-feedback'><ul>#{messages.join('')}</ul></div>"
  # end

  if html_tag.exclude?("class")
    html_tag[" "] = " class='is-invalid' ".html_safe
  else
    html_tag['class="'] = 'class="is-invalid '.html_safe
  end
  html_tag

  # Apply the error message to the non-label tags
  # if html_tag =~ /<label/
  #   html_tag
  # else
  #   html_tag + format_error_message_to_html_list(instance).html_safe
  # end
end
