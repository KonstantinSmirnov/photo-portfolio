require 'rails_helper'

RSpec.describe Setting, type: :model do
  let(:setting) { FactoryGirl.create(:setting) }

  it 'has a valid factory' do
    expect(setting).to be_valid
  end

  it 'is invalid wihtout webpage title' do
    setting.webpage_title = ''

    expect(setting).to be_invalid
    expect(setting.errors[:webpage_title]).to include("can't be blank")
  end

  it 'is invali with seo description longer than 170 symbols' do
    description = 'a'* 171

    setting.seo_description = description

    expect(setting).to be_invalid
    expect(setting.errors[:seo_description]).to include("is too long (maximum is 170 characters)")
  end

  it "is invalid with a seo keywords longer than 255 symbols" do
    keywords = 'a'* 256

    setting.seo_keywords = keywords

    expect(setting).to be_invalid
    expect(setting.errors[:seo_keywords]).to include("is too long (maximum is 255 characters)")
  end

  it 'is valid with webpage title' do
    setting.webpage_title = 'another title'

    expect(setting).to be_valid
  end
end
