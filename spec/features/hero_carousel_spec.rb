require 'rails_helper'

feature 'HERO CAROUSEL', js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_hero_carousel_slides_path
  end

  context 'Add new slide' do

    scenario 'it fails without image' do
      click_link 'Add'

      fill_in 'hero_carousel_slide_title', with: 'some test'
      fill_in 'hero_carousel_slide_subtitle', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.hero_carousel_slide_image.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without title' do
      click_link 'Add'

      page.attach_file('hero_carousel_slide_image', Rails.root + 'public/images/test_image.png')
      fill_in 'hero_carousel_slide_title', with: ''
      fill_in 'hero_carousel_slide_subtitle', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.hero_carousel_slide_title.has-error span.help-block', text: 'is too short (minimum is 1 character)')
    end

    scenario 'it fails without subtitle' do
      click_link 'Add'

      page.attach_file('hero_carousel_slide_image', Rails.root + 'public/images/test_image.png')
      fill_in 'hero_carousel_slide_title', with: 'some text'
      fill_in 'hero_carousel_slide_subtitle', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.hero_carousel_slide_subtitle.has-error span.help-block', text: 'is too short (minimum is 1 character)')
    end

    scenario 'it succeed with valid data' do
      click_link 'Add'

      page.attach_file('hero_carousel_slide_image', Rails.root + 'public/images/test_image.png')
      fill_in 'hero_carousel_slide_title', with: 'some text'
      fill_in 'hero_carousel_slide_subtitle', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW SLIDE HAS BEEN CREATED')
    end

    scenario 'it can be cancelled when creating "new" slide' do
      click_link 'Add'

      click_link 'Cancel'

      expect(page).not_to have_text('CREATE')
    end
  end

  context 'Update slide' do

    before(:each) do
      click_link 'Add'

      page.attach_file('hero_carousel_slide_image', Rails.root + 'public/images/test_image.png')
      fill_in 'hero_carousel_slide_title', with: 'some text'
      fill_in 'hero_carousel_slide_subtitle', with: 'some text'

      click_button 'Create'
    end

    scenario 'can start editing slide' do
      click_link 'Edit'

      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editind slide' do
      click_link 'Edit'

      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can update slide with valid data' do
      click_link 'Edit'

      fill_in 'hero_carousel_slide_title', with: 'new title'
      fill_in 'hero_carousel_slide_subtitle', with: 'some text'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SLIDE HAS BEEN UPDATED')
      expect(page).to have_text('NEW TITLE')
    end

    scenario 'can delete slide' do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SLIDE HAS BEEN DELETED')
    end

  end
end
