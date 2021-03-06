class Admin::ProjectsController < AdminController
  def index
    @projects = Portfolio.first.projects.order('date DESC')
  end

  def show
    @project = Project.find(params[:id])
    @photos = @project.photos.order(:position)
  end

  def new
    @project = Portfolio.first.projects.new
  end

  def create
    @project = Portfolio.first.projects.new(project_params)

    if @project.save
      flash[:success] = 'Project has been created'
      redirect_to admin_project_path(@project)
    else
      flash.now[:danger] = 'Please check errors'
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(project_params)
        flash.now[:success] = 'Project has been updated'
        format.js
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      flash.now[:success] = 'Project has been deleted'
      format.js { render 'destroy' }
    end
  end

  def cancel
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.js { render 'update' }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :date, :category_id)
  end
end
