require 'rails_helper'

feature 'CATEGORY', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_portfolio_path
  end

  context 'Add new category' do

    scenario 'it fails without text' do
      click_link 'Add category'

      fill_in 'category_title', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.category_title.has-error span.help-block', text: "can't be blank")
    end


    scenario 'it succeed with valid data' do
      click_link 'Add category'

      fill_in 'category_title', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW CATEGORY HAS BEEN CREATED')
    end

    scenario 'it can be cancelled when creating "new" category' do
      click_link 'Add category'

      click_link 'Cancel'
    
      expect(page).not_to have_text('CANCEL')
    end
  end

  context 'Update category' do

    before(:each) do
      click_link 'Add category'

      fill_in 'category_title', with: 'some text'

      click_button 'Create'

      within "#categories-list" do
        first(:link, "Edit").click
      end
    end

    scenario 'can start editing category' do
      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editind category' do
      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can update category with valid data' do
      fill_in 'category_title', with: 'new text'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CATEGORY HAS BEEN UPDATED')
      expect(page).to have_selector('h5', text: 'new text')
    end

    scenario 'can delete category' do
      visit admin_portfolio_path

      within "#categories-list" do
        first(:link, "Delete").click
      end
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CATEGORY HAS BEEN DELETED')
    end

  end
end
