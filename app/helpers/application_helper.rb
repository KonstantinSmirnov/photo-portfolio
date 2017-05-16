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
      link_to t('portfolio.back_home'), root_path, class: 'nav-link'
    else
      link_to t('portfolio.back_portfolio'), categories_path, class: 'nav-link'
    end
  end

  def title(page_title)
    content_for(:title) { page_title.upcase }
  end

  def meta_description(page_description)
    content_for(:meta_description) { page_description }
  end

  def meta_keywords(page_keywords)
    content_for(:meta_keywords) { page_keywords }
  end

end
