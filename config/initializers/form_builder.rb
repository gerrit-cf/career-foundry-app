module ActionView::Helpers
  class FormBuilder
    def errors(attribute)
      return if object.errors[attribute].empty?
      full_messages = object.errors.full_messages_for(attribute).join('<br>')
      "<div class=\"scoped-field-errors\">#{full_messages}</div>".html_safe
    end
  end
end
