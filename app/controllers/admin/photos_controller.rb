class Admin::PhotosController < AdminController

  def new
    @project = Project.find(params[:project_id])
    @photo = @project.photos.build
    @photo.id = Time.now

    respond_to do |format|
      format.js { render 'new' }
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @photo = @project.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        flash.now[:success] = 'New photo has been created'
        format.js { render 'replace', object: @photo }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'update_new' }
      end
    end
  end

  def edit
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(photo_params)
        flash.now[:success] = 'Photo has been updated'
        format.js { render 'show', object: @photo }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    respond_to do |format|
      @photo.destroy
      flash.now[:success] = 'Photo has been deleted'
      format.js { render 'destroy', object: @photo }
    end
  end

  def remove_new_form
    @project = Project.find(params[:project_id])
    @photo = @project.photos.new
    @photo.id = params[:photo_id]

    respond_to do |format|
      format.js { render 'destroy', object: @photo }
    end
  end

  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.js { render 'show', object: @photo }
    end
  end

  def sort
    params[:photo].each_with_index do |id, index|
      Photo.find(id).update_attribute(:position, index)
    end

    render nothing: true
  end

  private

  def photo_params
    params.require(:photo).permit(:alt, :image)
  end
end
