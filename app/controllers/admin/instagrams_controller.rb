class Admin::InstagramsController < AdminController
  require 'net/http'
  require 'open-uri'

  def show
    @instagram = Instagram.first
  end

  def new
    @instagram = Instagram.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @instagram = Instagram.new(instagram_params)

    respond_to do |format|
      if @instagram.save
        flash.now[:success] = 'Instagram section has been created'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @instagram = Instagram.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @instagram = Instagram.first

    respond_to do |format|
      if @instagram.update_attributes(instagram_params)
        flash.now[:success] = 'Instagram section has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @instagram = Instagram.first
    @instagram.delete

    flash[:success] = 'Successfully deleted'
    redirect_to admin_instagram_path
  end

  def cancel
    @instagram = Instagram.first

    respond_to do |format|
      format.js { render 'update_show' }
    end
  end

  def access_token
    uri = URI.parse("https://api.instagram.com/oauth/access_token")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request_to_instagram = Net::HTTP::Post.new(uri.request_uri)
    request_to_instagram.set_form_data({
      "client_id" => ENV['INSTAGRAM_CLIENT_ID'],
      "client_secret" => ENV['INSTAGRAM_CLIENT_SECRET'],
      "grant_type" => 'authorization_code',
      "redirect_uri" => "#{request.base_url}/admin/instagram/access_token",
      "code" => params[:code]
      })

    response = http.request(request_to_instagram)

    parsed_json = JSON.parse(response.body)

    access_token = parsed_json['access_token']
    username = parsed_json['user']['username']
    profile_picture = parsed_json['user']['profile_picture']

    @instagram = Instagram.first
    @instagram.update_attributes(
      :access_token => access_token,
      :username => username,
      :profile_picture => profile_picture
      )
    @instagram.save!
    redirect_to admin_instagram_path
  end

  private

  def instagram_params
    params.require(:instagram).permit(:text)
  end
end
