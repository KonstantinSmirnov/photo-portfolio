require 'rails_helper'

feature 'BLOG', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  
  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_blog_path
  end
  
  context 'Create blog' do
    before(:each) do
      click_link 'Create'
    end
    
    scenario 'it fails without title' do
      fill_in 'blog_title', with: ''
      
      click_button 'Create Blog'
      
      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.blog_title.has-error span.help-block', text: "поле не заполнено")
    end
    
    scenario 'it succeed with valid data' do
      fill_in 'blog_title', with: 'test title'
      
      click_button 'Create Blog'
      
      expect(page).to have_selector('.flash-alert.flash-success', text: 'BLOG HAS BEEN CREATED')
    end
    
    scenario 'it has cancel button' do
      click_link 'Cancel'
      
      expect(page).to have_selector('h3', text: 'BLOG IS NOT CREATED')
    end
  end
  
  context 'Update blog' do
    let!(:blog) { FactoryGirl.create(:blog) }
    
    before(:each) do
      visit admin_blog_path
      click_link 'Edit'
    end
    
    scenario 'it fails without title' do
      fill_in 'blog_title', with: ''
      
      click_button 'Update Blog'
      
      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.blog_title.has-error span.help-block', text: "поле не заполнено")
    end
    
    scenario 'it has cancel button' do
      click_link 'Cancel'
      
      expect(page).to have_selector('p', text: blog.title)
    end
    
    scenario 'delete blog' do
      visit admin_blog_path
      
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      
      expect(page).to have_selector('.flash-alert.flash-success', text: 'SUCCESSFULLY DELETED')
    end
  end

end