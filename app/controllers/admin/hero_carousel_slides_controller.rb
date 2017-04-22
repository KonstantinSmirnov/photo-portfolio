class Admin::HeroCarouselSlidesController < AdminController
  def index
    @slides = HeroCarouselSlide.all
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
      @hero_carousel_slide.delete
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

  private

  def slide_params
    params.require(:hero_carousel_slide).permit(:title, :subtitle)
  end
end
