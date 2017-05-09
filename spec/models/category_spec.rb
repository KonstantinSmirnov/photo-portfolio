require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create(:category) }

  it "has a valid factory" do
    expect(category).to be_valid
  end

  it "is invalid without title" do
    category.title = ''

    expect(category).to be_invalid
    expect(category.errors[:title]).to include("can't be blank")
  end
end
