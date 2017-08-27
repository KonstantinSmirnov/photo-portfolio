require 'rails_helper'

RSpec.describe About, type: :model do
  it 'has a valid factory' do
    about = FactoryGirl.create(:about)

    expect(about).to be_valid
  end

  describe 'Create' do
    it 'is invalid without title' do
      about = FactoryGirl.build(:about, title: '')

      expect(about).to be_invalid
      expect(about.errors[:title]).to include('поле не заполнено')
    end

    it 'is invald without text' do
      about = FactoryGirl.build(:about, text: '')

      expect(about).to be_invalid
      expect(about.errors[:text]).to include('поле не заполнено')
    end

    it 'is invalid without portrait' do
      about = FactoryGirl.build(:about, portrait: '')

      expect(about).to be_invalid
      expect(about.errors[:portrait]).to include('поле не заполнено')
    end

    it 'is invalid without signature' do
      about = FactoryGirl.build(:about, signature: '')

      expect(about).to be_invalid
      expect(about.errors[:signature]).to include('поле не заполнено')
    end
  end

  describe 'Update' do
    let(:about) { FactoryGirl.create(:about) }

    it 'is invalid without title' do
      about.title = ''

      expect(about).to be_invalid
      expect(about.errors[:title]).to include('поле не заполнено')
    end

    it 'is invalid without text' do
      about.text = ''

      expect(about).to be_invalid
      expect(about.errors[:text]).to include('поле не заполнено')
    end
  end
end
