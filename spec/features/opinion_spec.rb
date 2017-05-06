require 'rails_helper'

feature 'OPINION', js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_opinions_path
  end

  context 'Add new opinion' do

    scenario 'opinions section is hidden on home page if no opinions created' do
      visit root_path

      expect(page).not_to have_selector('h2.text-center', text: 'OPINIONS')
    end

    scenario 'it fails without image' do
      click_link 'Add'

      fill_in 'opinion_text', with: 'some test'
      fill_in 'opinion_author', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.opinion_image.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without text' do
      click_link 'Add'

      page.attach_file('opinion_image', Rails.root + 'public/images/test_image.png')
      fill_in 'opinion_text', with: ''
      fill_in 'opinion_author', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.opinion_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without author' do
      click_link 'Add'

      page.attach_file('opinion_image', Rails.root + 'public/images/test_image.png')
      fill_in 'opinion_text', with: 'some text'
      fill_in 'opinion_author', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.opinion_author.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      click_link 'Add'

      page.attach_file('opinion_image', Rails.root + 'public/images/test_image.png')
      fill_in 'opinion_text', with: 'some text'
      fill_in 'opinion_author', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW OPINION HAS BEEN CREATED')
    end

    scenario 'it unhides opinions section on home page if created at least one opinion' do
      click_link 'Add'

      page.attach_file('opinion_image', Rails.root + 'public/images/test_image.png')
      fill_in 'opinion_text', with: 'some text'
      fill_in 'opinion_author', with: 'some text'
      click_button 'Create'

      visit root_path
      expect(page).to have_selector('h2.text-center', text: 'OPINIONS')
    end

    scenario 'it can be cancelled when creating "new" opinion' do
      click_link 'Add'

      click_link 'Cancel'

      expect(page).not_to have_text('CANCEL')
    end
  end

  context 'Update opinion' do

    before(:each) do
      click_link 'Add'

      page.attach_file('opinion_image', Rails.root + 'public/images/test_image.png')
      fill_in 'opinion_text', with: 'some text'
      fill_in 'opinion_author', with: 'some text'

      click_button 'Create'
    end

    scenario 'can start editing opinion' do
      click_link 'Edit'

      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editind opinion' do
      click_link 'Edit'

      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can update opinion with valid data' do
      click_link 'Edit'

      fill_in 'opinion_text', with: 'new text'
      fill_in 'opinion_author', with: 'some text'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'OPINION HAS BEEN UPDATED')
      expect(page).to have_selector('p', text: 'new text')
    end

    scenario 'can delete opinion' do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'OPINION HAS BEEN DELETED')
    end

  end
end