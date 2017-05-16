require 'rails_helper'

RSpec.describe Opinion, type: :model do
  it 'has a valid factory' do
    opinion = FactoryGirl.build(:opinion)

    expect(opinion).to be_valid
  end

  it 'is invalid without text' do
    opinion = FactoryGirl.build(:opinion, text: '')

    expect(opinion).to be_invalid
    expect(opinion.errors[:text]).to include("can't be blank")
  end

  it 'is invalid without author' do
    opinion = FactoryGirl.build(:opinion, author: '')

    expect(opinion).to be_invalid
    expect(opinion.errors[:author]).to include("can't be blank")
  end

  it 'is invalid without image' do
    opinion = FactoryGirl.build(:opinion, image: '')

    expect(opinion).to be_invalid
    expect(opinion.errors[:image]).to include("can't be blank")
  end

  it "assigns next position id when created" do
    position = Opinion.count
    opinion = FactoryGirl.create(:opinion)

    expect(opinion.position).to eq(position)
  end
end
