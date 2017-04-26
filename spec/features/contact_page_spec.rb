require 'rails_helper'

feature 'CONTACT PAGE', js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_contact_path
    click_link 'Create'
  end

  context 'Create contact page' do
    scenario 'it does not exist if contact page is not created' do
      expect(Contact.count).to eq(0)

      visit root_path

      expect(page).not_to have_selector('a.nav-link', text: 'Contact')
    end

    scenario 'it fails without text' do
      fill_in 'contact_text', with: ''
      page.attach_file('contact_image', Rails.root + 'public/images/test_image.png')
      click_button 'Create Contact'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.contact_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without image' do
      fill_in 'contact_text', with: 'test text'
      # No image
      click_button 'Create Contact'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.contact_image.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      control_text = 'test text 123'
      fill_in 'contact_text', with: control_text
      page.attach_file('contact_image', Rails.root + 'public/images/test_image.png')
      click_button 'Create Contact'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CONTACT PAGE HAS BEEN CREATED')
      expect(current_path).to eq(admin_contact_path)
      expect(page).to have_text(control_text)
    end

    scenario 'page exists if contact page is created' do
      control_text = 'test text 123'
      fill_in 'contact_text', with: control_text
      page.attach_file('contact_image', Rails.root + 'public/images/test_image.png')
      click_button 'Create Contact'

      visit root_path
      click_link 'Contact'
      expect(page).to have_text(control_text)
    end
  end

  context 'Update' do
    let!(:contact) { FactoryGirl.create(:contact) }

    before(:each) do
      visit admin_contact_path
      click_link 'Edit'
    end

    scenario 'it fails without text' do
      fill_in 'contact_text', with: ''
      click_button 'Update Contact'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.contact_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('p', text: contact.text)
    end

    scenario 'it succeed with valid data' do
      control_text = 'test text 123455'
      fill_in 'contact_text', with: control_text
      click_button 'Update Contact'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CONTACT PAGE HAS BEEN UPDATED')
      expect(page).to have_selector('p', text: control_text)
    end

    scenario 'delete contact page' do
      visit admin_contact_path

      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SUCCESSFULLY DELETED')
    end
  end
end
