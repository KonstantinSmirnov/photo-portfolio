require 'rails_helper'

feature "INSTGRAM", js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_instagram_path
  end

  context 'Add instagram section' do
    before(:each) do
      click_link 'Create'
    end

    scenario 'it fails without text' do
      fill_in 'instagram_text', with: ''
      click_button 'Create Instagram'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.instagram_text.has-error span.help-block', text: "поле не заполнено")
    end

    scenario 'it succeed with valid data' do
      control_text = 'test text line'
      fill_in 'instagram_text', with: control_text
      click_button 'Create Instagram'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'INSTAGRAM SECTION HAS BEEN CREATED')
      expect(current_path).to eq(admin_instagram_path)
      expect(page).to have_text(control_text)
    end

    scenario 'added instagram section is invisible on home page without authorization' do
      text = 'test text line'
      fill_in 'instagram_text', with: text
      click_button 'Create Instagram'

      visit root_path

      expect(page).not_to have_selector('p', text: text, visible: false)
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: 'SECTION IS NOT CREATED')
    end
  end

  context 'Update instagram section' do
    let!(:instagram) { FactoryGirl.create(:instagram) }

    before(:each) do
      visit admin_instagram_path
      click_link 'Edit'
    end

    scenario 'it fails without text' do
      fill_in 'instagram_text', with: ''
      click_button 'Update Instagram'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.instagram_text.has-error span.help-block', text: "поле не заполнено")
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('p', text: instagram.text)
    end

    scenario 'delete instagram section' do
      visit admin_instagram_path

      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SUCCESSFULLY DELETED')
    end
  end

end
