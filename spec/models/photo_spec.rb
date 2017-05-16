require 'rails_helper'

RSpec.describe Photo, type: :model do

  it 'has a valid factory' do
    photo = FactoryGirl.build(:photo)

    expect(photo).to be_valid
  end

  it 'is invalid without alt text' do
    photo = FactoryGirl.build(:photo, alt: '')

    expect(photo).to be_invalid
    expect(photo.errors[:alt]).to include("can't be blank")
  end

  it 'is invalid without image' do
    photo = FactoryGirl.build(:photo, image: '')

    expect(photo).to be_invalid
    expect(photo.errors[:image]).to include("can't be blank")
  end

  it "assigns next position id when created" do
    project = FactoryGirl.create(:project)
    position_1 = project.photos.count
    photo_1 = FactoryGirl.create(:photo, project: project)
    position_2 = project.photos.count
    photo_2 = FactoryGirl.create(:photo, project: project)

    expect(photo_1.position).to eq(position_1)
    expect(photo_2.position).to eq(position_2)
  end
end
