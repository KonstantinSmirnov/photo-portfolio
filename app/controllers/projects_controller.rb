class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @photos = @project.photos.order(:position)
  end
end
