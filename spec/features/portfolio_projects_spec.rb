require 'rails_helper'

feature 'PORTFOLIO PROJECTS', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }

  before(:each) do
    log_in_with(admin.email, 'password')
  end

  context 'Add project' do
    before(:each) do
      visit admin_portfolio_path
      click_link 'Add project'
    end

    scenario 'it has a button to go back to the list' do
      click_link 'Back'

      expect(current_path).to eq(admin_portfolio_path)
      expect(page).to have_selector('h3', text: 'PROJECTS')
    end

    scenario 'it fails without title' do
      fill_in 'project_title', with: ''
      fill_in 'project_description', with: 'test description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without description' do
      fill_in 'project_title', with: 'test title'
      fill_in 'project_description', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_description.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with correct data' do
      fill_in 'project_title', with: 'test title'
      fill_in 'project_description', with: 'test description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PROJECT HAS BEEN CREATED')
      expect(current_path).to eq(admin_project_path(Project.last))
      expect(page).to have_selector('h3', text: 'TEST TITLE')
    end
  end

  context 'See and delete project' do
    let!(:project) { FactoryGirl.create(:project, portfolio: portfolio) }

    before(:each) do
      visit admin_portfolio_path
    end

    scenario 'it has show button on index page' do
      click_link 'Show'

      expect(current_path).to eq(admin_project_path(project))
    end

    scenario 'it has delete button on index page' do
      within "#projects" do
        first(:link, "Delete").click
      end
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PROJECT HAS BEEN DELETED')
      expect(page).not_to have_text(project.title)
    end
  end

  context 'Update project' do
    let!(:project) { FactoryGirl.create(:project) }

    before(:each) do
      visit admin_project_path(project)
      click_link 'Edit'
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).not_to have_selector('.btn', text: 'UPDATE')
    end

    scenario 'it fails without title' do
      fill_in 'project_title', with: ''
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without description' do
      fill_in 'project_description', with: ''
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_description.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      fill_in 'project_title', with: 'some title'
      fill_in 'project_description', with: 'some description'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PROJECT HAS BEEN UPDATED')
    end

  end

end
