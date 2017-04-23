module ApplicationHelper

  def is_active?(controller)
    'active' if controller.include?(params[:controller])
  end

  def is_active_namespace?(namespace)
    'active' if namespace.include?(params[:controller].split('/').first)
  end

  def get_instagram_access_token_url
    redirect_uri = request.base_url + '/admin/instagram/access_token'
    "https://api.instagram.com/oauth/authorize/?client_id=" + ENV['INSTAGRAM_CLIENT_ID'] + "&redirect_uri=" + redirect_uri + "&response_type=code"
  end

end
