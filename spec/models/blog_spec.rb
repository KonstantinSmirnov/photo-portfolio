require 'rails_helper'

RSpec.describe Blog, type: :model do
  it 'has a valid factory' do
    blog = FactoryGirl.create(:blog)
    
    expect(blog).to be_valid
  end
  
  describe 'Create' do
    it 'is invalid without title' do
      blog = FactoryGirl.build(:blog, title: '')
      
      expect(blog).to be_invalid
      expect(blog.errors[:title]).to include("поле не заполнено")
    end
  end
  
  describe 'Update' do
    let(:blog) { FactoryGirl.create(:blog) }
    
    it 'is invalid without tilte' do
      blog.title = ''
      
      expect(blog).to be_invalid
      expect(blog.errors[:title]).to include("поле не заполнено")
    end
  end
end
