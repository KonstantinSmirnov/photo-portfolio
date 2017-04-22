require 'rails_helper'

feature 'ACCOUNT' do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_account_path
  end

  context 'user tries to update email' do
    scenario 'fails if password is empty' do
      fill_in 'update_email_email', with: 'another@email.com'
      fill_in 'update_email_password', with: ''
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'Invalid password')
    end

    scenario 'fails if password is invalid' do
      fill_in 'update_email_email', with: 'another@email.com'
      fill_in 'update_email_password', with: 'invalid_password'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'Invalid password')
    end

    scenario 'not updated if email is empty' do
      fill_in 'update_email_email', with: ''
      fill_in 'update_email_password', with: 'password'
      click_button 'Update'

      expect(find_field('update_email_email').value).to eq(admin.email)
    end

    scenario 'updates with valid password' do
      new_email = 'new@email.com'
      fill_in 'update_email_email', with: new_email
      fill_in 'update_email_password', with: 'password'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'Email has been updated')
      expect(find_field('update_email_email').value).to eq(new_email)
    end
  end
end
