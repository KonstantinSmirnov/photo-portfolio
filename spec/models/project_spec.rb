require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryGirl.create(:project) }

  it 'has a valid factory' do
    expect(project).to be_valid
  end

  it 'is invalid without title' do
    project.title = ''

    expect(project).to be_invalid
    expect(project.errors[:title]).to include('поле не заполнено')
  end

  it 'is invalid without date' do
    project.date = ''

    expect(project).to be_invalid
    expect(project.errors[:date]).to include('поле не заполнено')
  end
end
