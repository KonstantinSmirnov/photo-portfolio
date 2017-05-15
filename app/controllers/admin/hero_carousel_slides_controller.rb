class Admin::HeroCarouselSlidesController < AdminController
  def index
    @slides = HeroCarouselSlide.order(:position)
  end

  def new
    @hero_carousel_slide = HeroCarouselSlide.new
    @hero_carousel_slide.id = Time.now

    respond_to do |format|
      format.js { render 'new' }
    end
  end

  def create
    @hero_carousel_slide = HeroCarouselSlide.new(slide_params)
    @hero_carousel_slide.position = HeroCarouselSlide.count

    respond_to do |format|
      if @hero_carousel_slide.save
        flash.now[:success] = 'New slide has been created'
        format.js { render 'replace', object: @hero_carousel_slide }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'update_new' }
      end
    end
  end

  def edit
    @hero_carousel_slide = HeroCarouselSlide.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @hero_carousel_slide = HeroCarouselSlide.find(params[:id])

    respond_to do |format|
      if @hero_carousel_slide.update_attributes(slide_params)
        flash.now[:success] = 'Slide has been updated'
        format.js { render 'show', object: @hero_carousel_slide }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @hero_carousel_slide = HeroCarouselSlide.find(params[:id])

    respond_to do |format|
      @hero_carousel_slide.destroy
      flash.now[:success] = 'Slide has been deleted'
      format.js { render 'destroy', object: @hero_carousel_slide }
    end
  end

  def remove_new_form
    @hero_carousel_slide = HeroCarouselSlide.new
    @hero_carousel_slide.id = params[:slide_id]

    respond_to do |format|
      format.js { render 'destroy', object: @hero_carousel_slide }
    end
  end

  def show
    @hero_carousel_slide = HeroCarouselSlide.find(params[:id])

    respond_to do |format|
      format.js { render 'show', object: @hero_carousel_slide }
    end
  end

  def sort
    puts params.inspect
    params[:slide].each_with_index do |id, index|
      HeroCarouselSlide.find(id).update_attribute(:position, index)
    end

    render nothing: true
  end

  private

  def slide_params
    params.require(:hero_carousel_slide).permit(:title, :subtitle, :image)
  end
end
