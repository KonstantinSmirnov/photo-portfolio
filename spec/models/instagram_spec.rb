require 'rails_helper'

RSpec.describe Instagram, type: :model do
  it 'has a valid factory' do
    instagram = FactoryGirl.create(:instagram)

    expect(instagram).to be_valid
  end

  describe 'Create' do
    it 'is invald without text' do
      instagram = FactoryGirl.build(:instagram, text: '')

      expect(instagram).to be_invalid
      expect(instagram.errors[:text]).to include('поле не заполнено')
    end
  end

  describe 'Update' do
    let(:instagram) { FactoryGirl.create(:instagram) }

    it 'is invalid without text' do
      instagram.text = ''

      expect(instagram).to be_invalid
      expect(instagram.errors[:text]).to include('поле не заполнено')
    end
  end
end
