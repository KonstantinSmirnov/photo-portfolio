module ApplicationHelper
  def is_active?(item)
    case item
    when 'home'
      'active' if controller?('static_pages')
    when 'admin'
      'active' if namespace?('admin')
    when 'admin/dashboard'
      'active' if controller?('admin/dashboard')
    end
  end

  def namespace?(namespace)
      namespace.include?(params[:controller].split('/').first)
  end

  def controller?(controller)
    controller.include?(params[:controller])
  end

  def action?(action)
    action.include?(params[:action])
  end
end
