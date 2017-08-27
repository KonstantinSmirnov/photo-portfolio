require 'rails_helper'

feature 'ARTICLE', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:blog) { FactoryGirl.create(:blog) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_blog_path
  end

  context 'Create article' do
    before(:each) do
      click_link 'New Article'
    end

    scenario 'it fails without title' do
      fill_in 'article_title', with: ''
      fill_in 'article_content', with: 'test content'

      click_button 'Create Article'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.article_title.has-error span.help-block', text: 'поле не заполнено')
    end

    scenario 'it fails without content' do
      fill_in 'article_title', with: 'test title'
      fill_in 'article_content', with: ''

      click_button 'Create Article'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.article_content.has-error span.help-block', text: 'поле не заполнено')
    end

    scenario 'it succeed with valid data' do
      fill_in 'article_title', with: 'test article title'
      fill_in 'article_content', with: 'test article content'

      click_button 'Create Article'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ARTICLE HAS BEEN CREATED')
      expect(current_path).to eq(admin_blog_article_path(Article.last))
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: 'ARTICLES')
    end
  end

  context 'Show article' do
    let!(:article) { FactoryGirl.create(:article, blog: blog) }

    scenario 'you can see article clicking by its title' do
      visit admin_blog_path

      click_link article.title

      expect(current_path).to eq(admin_blog_article_path(article))
    end
  end

  context 'Update article' do
    let!(:article) { FactoryGirl.create(:article, blog: blog) }

    before(:each) do
      visit admin_blog_article_path(article)
      click_link 'Edit'
    end

    scenario 'it fails wihtout title' do
      fill_in 'article_title', with: ''

      click_button 'Update Article'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.article_title.has-error span.help-block', text: 'поле не заполнено')
    end

    scenario 'it fails wihtout content' do
      fill_in 'article_content', with: ''

      click_button 'Update Article'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.article_content.has-error span.help-block', text: 'поле не заполнено')
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(current_path).to eq(admin_blog_article_path(article))
    end

    scenario 'can publish'
      expect(article.status).to eq('draft')

      select('published', from: 'article_status').select_option
      click_button 'Update Article'
      article.reload

      expect(article.status).to eq('published')
      expect(article.publication_date).to eq(Date.today)
    end

    scenario 'can edit article from articles list (blog show) as well' do
      visit admin_blog_path

      within '#articles-list' do
        first(:link, 'Edit').click
      end

      expect(current_path).to eq(edit_admin_blog_article_path(article))
    end
  end

  context 'Delete article' do
    scenario 'assign article status Deleted if not asigned from articles list' do
      article = FactoryGirl.create(:article, blog: blog)
      expect(article.status).to eq('draft')

      visit admin_blog_path

      within '#articles-list' do
        first(:link, 'Delete').click
      end

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ARTICLE HAS BEEN MOVED TO DELETED')
      expect(current_path).to eq(admin_blog_path)

      article.reload
      expect(article.status).to eq('deleted')
    end

    scenario 'can delete article from articles list with status Deleted' do
      article = FactoryGirl.create(:article, blog: blog)
      article.deleted!
      visit admin_blog_path

      within '#articles-list' do
        first(:link, 'Delete').click
      end
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ARTICLE HAS BEEN DELETED')
      expect(page).not_to have_text(article.title)
    end

    scenario 'assign article status Deleted if not asigned from show article' do
      article = FactoryGirl.create(:article, blog: blog)
      expect(article.status).to eq('draft')

      visit admin_blog_article_path(article)

      click_link 'Delete'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ARTICLE HAS BEEN MOVED TO DELETED')
      expect(current_path).to eq(admin_blog_article_path(article))

      article.reload
      expect(article.status).to eq('deleted')
    end

    scenario 'can delete articles from show article with status deleted' do
      article = FactoryGirl.create(:article, blog: blog)
      article.deleted!
      visit admin_blog_article_path(article)

      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ARTICLE HAS BEEN DELETED')
      expect(page).not_to have_text(article.title)
    end
  end
end
