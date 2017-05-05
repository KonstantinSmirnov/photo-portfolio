class Admin::OpinionsController < AdminController
  def index
    @opinions = Opinion.all
  end

  def new
    @opinion = Opinion.new
    @opinion.id = Time.now

    respond_to do |format|
      format.js { render 'new' }
    end
  end

  def create
    @opinion = Opinion.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        flash.now[:success] = 'New opinion has been created'
        format.js { render 'replace', object: @opinion }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'update_new' }
      end
    end
  end

  def edit
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      if @opinion.update_attributes(opinion_params)
        flash.now[:success] = 'Opinion has been updated'
        format.js { render 'show', object: @opinion }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      @opinion.delete
      flash.now[:success] = 'opinion has been deleted'
      format.js { render 'destroy', object: @opinion }
    end
  end

  def remove_new_form
    @opinion = Opinion.new
    @opinion.id = params[:opinion_id]
    
    respond_to do |format|
      format.js { render 'destroy', object: @opinion }
    end
  end

  def show
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      format.js { render 'show', object: @opinion }
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:text, :author, :image)
  end

end
