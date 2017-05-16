require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create(:category) }

  it "has a valid factory" do
    expect(category).to be_valid
  end

  it "is invalid without title" do
    category.title = ''

    expect(category).to be_invalid
    expect(category.errors[:title]).to include("поле не заполнено")
  end

  it "assigns next position id when created" do
    position = Category.count
    category = FactoryGirl.create(:category)

    expect(category.position).to eq(position)
  end
end
