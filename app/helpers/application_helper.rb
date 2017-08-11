module ApplicationHelper
  def present(model)
    presenter_klass = "#{model.class}Presenter".constantize
    presenter_klass.new(model, self).tap do |presenter|
      yield presenter if block_given?
    end
  end

  def flash_class_for(type)
    type = type.eql?('error') ? 'danger' : type
    "alert alert-#{type}"
  end
end
