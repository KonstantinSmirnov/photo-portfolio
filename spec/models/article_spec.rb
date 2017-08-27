require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'has a valid factory' do
    article = FactoryGirl.create(:article)

    expect(article).to be_valid
  end

  describe 'Create' do
    it 'is invalid without title' do
      article = FactoryGirl.build(:article, title: '')

      expect(article).to be_invalid
      expect(article.errors[:title]).to include('поле не заполнено')
    end

    it 'is invalid without content' do
      article = FactoryGirl.build(:article, content: '')

      expect(article).to be_invalid
      expect(article.errors[:content]).to include('поле не заполнено')
    end

    it 'has status Draft after creation' do
      article = FactoryGirl.create(:article)

      expect(article).to be_valid
      expect(article.status).to eq('draft')
    end

    describe 'Update' do
      let(:article) { FactoryGirl.create(:article) }

      it 'is invalid without title' do
        article.title = ''

        expect(article).to be_invalid
        expect(article.errors[:title]).to include('поле не заполнено')
      end

      it 'is invalid without content' do
        article.content = ''

        expect(article).to be_invalid
        expect(article.errors[:content]).to include('поле не заполнено')
      end
      
      it 'updates publication date according selected status' do
        expect(article.status).to eq('draft')
        expect(article.publication_date).to eq(nil)
        
        article.published!
        article.reload
        
        expect(article.status).to eq('published')
        expect(article.publication_date).to eq(Date.today)
        
        article.draft!
        article.reload
        
        expect(article.status).to eq('draft')
        expect(article.publication_date).to eq(nil)
      end
    end
  end
end
