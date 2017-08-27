require 'rails_helper'

RSpec.describe HeroCarouselSlide, type: :model do
  it 'has a valid factory' do
    hero_carousel_slide = FactoryGirl.create(:hero_carousel_slide)

    expect(hero_carousel_slide).to be_valid
  end

  describe 'Create' do
    it 'is invalid without title' do
      hero_carousel_slide = FactoryGirl.build(:hero_carousel_slide, title: '')

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:title]).to include 'минимум 1 символ, не более 50 символов'
    end

    it 'is invalid without subtitle' do
      hero_carousel_slide = FactoryGirl.build(:hero_carousel_slide, subtitle: '')

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:subtitle]).to include('минимум 1 символ, не более 70 символов')
    end

    it 'is invalid without image' do
      hero_carousel_slide = FactoryGirl.build(:hero_carousel_slide, image: '')

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:image]).to include('поле не заполнено')
    end

    it 'is invalid with title longer than permitted' do
      long_title = 'a' * 51
      hero_carousel_slide = FactoryGirl.build(:hero_carousel_slide, title: long_title)

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:title]).to include('не более 50 символов')
    end

    it 'is invalid with subtitle longer than permitted' do
      long_subtitle = 'a' * 71
      hero_carousel_slide = FactoryGirl.build(:hero_carousel_slide, subtitle: long_subtitle)

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:subtitle]).to include('не более 70 символов')
    end

    it 'is valid with title and subtitle' do
      hero_carousel_slide = FactoryGirl.create(:hero_carousel_slide)

      expect(hero_carousel_slide).to be_valid
    end

    it 'assigns next position id when created' do
      position = HeroCarouselSlide.count
      hero_carousel_slide = FactoryGirl.create(:hero_carousel_slide)

      expect(hero_carousel_slide.position).to eq(position)
    end
  end

  describe 'Update' do
    let(:hero_carousel_slide) { FactoryGirl.create(:hero_carousel_slide) }

    it 'is invalid without title' do
      hero_carousel_slide.title = ''

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:title]).to include 'минимум 1 символ, не более 50 символов'
    end

    it 'is invalid without subtitle' do
      hero_carousel_slide.subtitle = ''

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:subtitle]).to include 'минимум 1 символ, не более 70 символов'
    end

    it 'is invalid if title is longer than permitted' do
      long_title = 'a' * 51
      hero_carousel_slide.title = long_title

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:title]).to include('не более 50 символов')
    end

    it 'is invalid if subtitle is longer than permitted' do
      long_subtitle = 'a' * 71
      hero_carousel_slide.subtitle = long_subtitle

      expect(hero_carousel_slide).to be_invalid
      expect(hero_carousel_slide.errors[:subtitle]).to include('не более 70 символов')
    end

    it 'is valid with valid title and subtitle ' do
      hero_carousel_slide.title = 'another'
      hero_carousel_slide.subtitle = 'another subtitle'

      expect(hero_carousel_slide).to be_valid
    end
  end
end
