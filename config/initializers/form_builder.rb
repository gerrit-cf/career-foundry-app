module ActionView::Helpers
  class FormBuilder
    def errors(attribute)
      return if object.errors[attribute].empty?
      full_message = object.errors.full_messages_for(attribute).first
      "<div class=\"scoped-field-errors\">#{full_message}</div>".html_safe
    end
  end
end
