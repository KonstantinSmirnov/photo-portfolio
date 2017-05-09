module ApplicationHelper

  def is_active?(controller)
    'active' if controller.include?(params[:controller])
  end

  def is_active_namespace?(namespace)
    'active' if namespace.include?(params[:controller].split('/').first)
  end

  def is_active_category?(category_id)
    if action_name == 'index' && category_id.nil?
      'active'
    else
      'active' if params[:id].to_i == category_id
    end
  end

  def get_instagram_access_token_url
    redirect_uri = request.base_url + '/admin/instagram/access_token'
    "https://api.instagram.com/oauth/authorize/?client_id=" + ENV['INSTAGRAM_CLIENT_ID'] + "&redirect_uri=" + redirect_uri + "&response_type=code"
  end

  def is_portfolio_project?(controller)
    true if controller.include?(params[:controller])
  end

  def go_back_link(page_from_params)
    case page_from_params
    when 'home_page'
      link_to '< Home', root_path, class: 'nav-link'
    else
      link_to '< Portfolio', categories_path, class: 'nav-link'
    end
  end

end
