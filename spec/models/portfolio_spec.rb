require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it 'has a valid factory' do
    portfolio = FactoryGirl.create(:portfolio)

    expect(portfolio).to be_valid
  end

  describe 'Create' do
    it 'is invalid without title' do
      portfolio = FactoryGirl.build(:portfolio, title: '')

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without home title' do
      portfolio = FactoryGirl.build(:portfolio, home_title: '')

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:home_title]).to include("can't be blank")
    end

    it 'is invald without description' do
      portfolio = FactoryGirl.build(:portfolio, description: '')

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:description]).to include("can't be blank")
    end
  end

  describe 'Update' do
    let(:portfolio) { FactoryGirl.create(:portfolio) }

    it 'is invalid without title' do
      portfolio.title = ''

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without home title' do
      portfolio.home_title = ''

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:home_title]).to include("can't be blank")
    end

    it 'is invalid without description' do
      portfolio.description = ''

      expect(portfolio).to be_invalid
      expect(portfolio.errors[:description]).to include("can't be blank")
    end
  end
end
