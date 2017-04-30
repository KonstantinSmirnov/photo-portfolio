require 'rails_helper'

feature 'PORTFOLIO PHOTO', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:project) { FactoryGirl.create(:project) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_project_path(project)
  end

  context 'Add photo' do

    before(:each) do
      click_link 'Add'
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).not_to have_text('CANCEL')
    end

    scenario 'it fails without alt text' do
      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_alt.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without image' do
      # Do not attach image
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_image.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeeds with valid data' do
      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW PHOTO HAS BEEN CREATED')
    end
  end

  context 'Update photo' do
    before(:each) do
      click_link 'Add'
      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Create'
    end

    scenario 'can start editing photo' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editing photo' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'it fails without alt text' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      fill_in 'photo_alt', with: ''
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_alt.has-error span.help-block', text: "can't be blank")
    end

    scenario 'can update photo with valid data' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PHOTO HAS BEEN UPDATED')
    end

    scenario 'can delete photo' do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PHOTO HAS BEEN DELETED')
    end
  end
end
