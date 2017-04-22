require 'rails_helper'

feature 'ACCOUNT' do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_account_path
  end

  context 'user tries to update email' do
    scenario 'it fails if password is empty' do
      fill_in 'update_email_email', with: 'another@email.com'
      fill_in 'update_email_password', with: ''
      click_button 'Update email'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'Invalid password')
    end

    scenario 'it fails if password is invalid' do
      fill_in 'update_email_email', with: 'another@email.com'
      fill_in 'update_email_password', with: 'invalid_password'
      click_button 'Update email'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'Invalid password')
    end

    scenario 'is not updated if email is empty' do
      fill_in 'update_email_email', with: ''
      fill_in 'update_email_password', with: 'password'
      click_button 'Update email'

      expect(find_field('update_email_email').value).to eq(admin.email)
    end

    scenario 'it updates with valid password' do
      new_email = 'new@email.com'
      fill_in 'update_email_email', with: new_email
      fill_in 'update_email_password', with: 'password'
      click_button 'Update email'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'Email has been updated')
      expect(find_field('update_email_email').value).to eq(new_email)
    end
  end

  context 'user tries to update password' do
    scenario 'it fails if password is empty' do
      fill_in 'update_password_password', with: ''
      click_button 'Update password'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'Invalid password')
    end

    scenario 'it fails if new password is empty' do
      fill_in 'update_password_password', with: 'password'
      click_button 'Update password'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'New password is invalid')
    end

    scenario 'it fails if new password is short' do
      fill_in 'update_password_password', with: 'password'
      fill_in 'update_password_new_password', with: '12'
      fill_in 'update_password_new_password_confirmation', with: '12'
      click_button 'Update password'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'New password is invalid')
    end

    scenario 'it fails if new password and confirmation do not match' do
      fill_in 'update_password_password', with: 'password'
      fill_in 'update_password_new_password', with: '123123'
      fill_in 'update_password_new_password_confirmation', with: '123'
      click_button 'Update password'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'New password is invalid')
    end

    scenario 'id succeed with valid data' do
      fill_in 'update_password_password', with: 'password'
      fill_in 'update_password_new_password', with: '123123'
      fill_in 'update_password_new_password_confirmation', with: '123123'
      click_button 'Update password'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'Password has been updated')
    end
  end
end
