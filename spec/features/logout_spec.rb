require 'rails_helper'

feature "LOGOUT" do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
  end

  scenario 'logs out' do
    click_link 'Log out'

    expect(page).to have_selector('.flash-alert.flash-success', text: 'You successfully logged out')
    expect(current_path).to eq(login_path)
  end
end
