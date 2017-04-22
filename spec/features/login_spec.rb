require 'rails_helper'

feature 'LOGIN' do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    visit login_path
  end

  scenario 'has login page' do
    expect(page).to have_selector('h2.text-center', text: 'Log in')
  end

  scenario 'fails without email' do
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: 'password'
    click_button 'Go'

    expect(page).to have_selector('.flash-alert.flash-danger', text: 'Login or password is invalid')
  end

  scenario 'fails without password' do
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: ''
    click_button 'Go'

    expect(page).to have_selector('.flash-alert.flash-danger', text: 'Login or password is invalid')
  end

  scenario 'fails with valid email, but for nonexistent user' do
    fill_in 'user_email', with: 'nonexistent@email.com'
    fill_in 'user_password', with: 'password'
    click_button 'Go'

    expect(page).to have_selector('.flash-alert.flash-danger', text: 'Login or password is invalid')
  end

  scenario 'logs in with valid email and password' do
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: 'password'
    click_button 'Go'

    expect(page).to have_selector('.flash-alert.flash-success', text: 'You logged in')
    expect(current_path).to eq(root_path)
  end
end
