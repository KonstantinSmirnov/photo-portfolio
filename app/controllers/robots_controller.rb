class RobotsController < ApplicationController
  layout nil

  def show
    respond_to :text
    expires_in 6.hours, public: true
  end
end
