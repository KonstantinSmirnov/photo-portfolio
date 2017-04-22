require 'rails_helper'

feature 'DASHBOARD' do
  context 'not logged in user' do
    scenario 'does not have access' do
      visit admin_dashboard_path

      expect(page).not_to have_selector('a.nav-link', text: 'Admin')
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in user' do
    let(:admin) { FactoryGirl.create(:admin) }

    before(:each) do
      log_in_with(admin.email, 'password')
    end

    scenario 'has admin page' do
      visit admin_dashboard_path

      expect(page).to have_selector('a.nav-link', text: 'Admin')
      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end
