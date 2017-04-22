module ApplicationHelper

  def is_active?(controller)
    'active' if controller.include?(params[:controller])
  end

  def is_active_namespace?(namespace)
    'active' if namespace.include?(params[:controller].split('/').first)
  end

end
