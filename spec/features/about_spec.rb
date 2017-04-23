require 'rails_helper'

feature "ABOUT", js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_about_path
  end

  context 'Add about section' do
    before(:each) do
      click_link 'Create'
    end

    scenario 'it fails without title' do
      fill_in 'about_title', with: ''
      fill_in 'about_text', with: 'test text'
      page.attach_file('about_portrait', Rails.root + 'public/images/test_image.png')
      page.attach_file('about_signature', Rails.root + 'public/images/test_image.png')
      click_button 'Create About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without text' do
      fill_in 'about_title', with: 'test title'
      fill_in 'about_text', with: ''
      page.attach_file('about_portrait', Rails.root + 'public/images/test_image.png')
      page.attach_file('about_signature', Rails.root + 'public/images/test_image.png')
      click_button 'Create About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without portrait' do
      fill_in 'about_title', with: 'test title'
      fill_in 'about_text', with: 'test text'
      # No portrait image
      page.attach_file('about_signature', Rails.root + 'public/images/test_image.png')
      click_button 'Create About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_portrait.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without signature' do
      fill_in 'about_title', with: 'test title'
      fill_in 'about_text', with: 'test text'
      page.attach_file('about_portrait', Rails.root + 'public/images/test_image.png')
      # No signature image
      click_button 'Create About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_signature.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      control_text = 'test text line'
      fill_in 'about_title', with: 'test title'
      fill_in 'about_text', with: control_text
      page.attach_file('about_portrait', Rails.root + 'public/images/test_image.png')
      page.attach_file('about_signature', Rails.root + 'public/images/test_image.png')
      click_button 'Create About'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'ABOUT SECTION HAS BEEN CREATED')
      expect(current_path).to eq(admin_about_path)
      expect(page).to have_text(control_text)
    end

    scenario 'added about section is visible on home page' do
      title = 'test title line'
      text = 'test text line'
      fill_in 'about_title', with: title
      fill_in 'about_text', with: text
      page.attach_file('about_portrait', Rails.root + 'public/images/test_image.png')
      page.attach_file('about_signature', Rails.root + 'public/images/test_image.png')
      click_button 'Create About'

      visit root_path
      expect(page).to have_selector('h2', text: title.upcase)
      expect(page).to have_selector('p', text: text)
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: 'SECTION IS NOT CREATED')
    end
  end

  context 'Update about section' do
    let!(:about) { FactoryGirl.create(:about) }

    before(:each) do
      visit admin_about_path
      click_link 'Edit'
    end

    scenario 'it fails without title' do
      fill_in 'about_title', with: ''
      fill_in 'about_text', with: 'test text'
      click_button 'Update About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without text' do
      fill_in 'about_title', with: 'test title'
      fill_in 'about_text', with: ''
      click_button 'Update About'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.about_text.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: about.title.upcase)
    end

    scenario 'delete about section' do
      visit admin_about_path

      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SUCCESSFULLY DELETED')
    end
  end

end
