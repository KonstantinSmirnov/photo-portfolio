require 'rails_helper'

feature 'PORTFOLIO PROJECTS', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }
  let!(:category) { FactoryGirl.create(:category) }

  before(:each) do
    log_in_with(admin.email, 'password')
  end

  context 'Add project' do
    before(:each) do
      visit admin_projects_path
      click_link 'Add project'
    end

    scenario 'it has a button to go back to the list' do
      click_link 'Back'

      expect(current_path).to eq(admin_projects_path)
      expect(page).to have_selector('h3', text: 'PROJECTS')
    end

    scenario 'it fails without date' do
      fill_in 'project_title', with: 'test title'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_date.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without title' do
      fill_in 'project_date', with: '2017-12-01'
      find('td.day', text: '15').click
      fill_in 'project_title', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.project_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with correct data' do
      fill_in 'project_date', with: '2017-12-01'
      find('td.day', text: '15').click
      fill_in 'project_title', with: 'test title'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PROJECT HAS BEEN CREATED')
      expect(current_path).to eq(admin_project_path(Project.last))
      expect(page).to have_selector('h3', text: 'TEST TITLE')
    end

    scenario 'it has no category when not assigned to a category' do
      fill_in 'project_date', with: '2017-12-01'
      find('td.day', text: '15').click
      fill_in 'project_title', with: 'test'
      click_button 'Create'

      expect(page).to have_selector('h5', text: 'Category: No category')
    end

    scenario 'it can be assigned to a category' do
      fill_in 'project_date', with: '2017-12-01'
      find('td.day', text: '15').click
      fill_in 'project_title', with: 'test'
      select(category.title, from: "project_category_id").select_option
      click_button 'Create'

      expect(page).to have_selector('h5', text: category.title)
    end
  end

  context 'See and delete project' do
    let!(:project) { FactoryGirl.create(:project, portfolio: portfolio) }

    before(:each) do
      visit admin_projects_path
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

    scenario 'it has date on index page' do
      expect(page).to have_selector('small', text: project.date.strftime("%d %B %Y"))
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

    scenario 'it succeed with valid data' do
      fill_in 'project_date', with: '2018-12-01'
      find('td.day', text: '20').click
      fill_in 'project_title', with: 'some title'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PROJECT HAS BEEN UPDATED')
    end

  end

  scenario 'it is unavailable if portfolio page not created' do
    portfolio.delete

    visit admin_dashboard_path

    expect(page).not_to have_selector('a.nav-link', text: 'Projects')
  end

  context 'projects order' do
    let!(:project_1) { FactoryGirl.create(:project, title: 'Project 1', date: 1.weeks.ago, portfolio: portfolio) }
    let!(:project_2) { FactoryGirl.create(:project, title: 'Project 2', date: 5.weeks.ago, portfolio: portfolio) }

    scenario 'newest project firt on admin projects page' do
      visit admin_projects_path

      expect(first('#projects h3')).to have_text('PROJECT 1')
    end

    scenario 'newest project firt on admin projects page after changing date' do
      project_2.date = Time.now
      project_2.save!

      visit admin_projects_path

      expect(first('#projects h3')).to have_text('PROJECT 2')
    end

    scenario 'newest project first on projects page' do
      visit categories_path

      projects = page.all('.project-preview .overlay h3', visible: :hidden)

      expect(projects[0]['innerHTML']).to have_text('Project 1')
    end

    scenario 'newest project first on projects page after changing date' do
      project_2.date = Time.now
      project_2.save!

      visit categories_path

      projects = page.all('.project-preview .overlay h3', visible: :hidden)

      expect(projects[0]['innerHTML']).to have_text('Project 2')
    end

    scenario 'newest best project first on home page' do
      visit categories_path

      projects = page.all('.project-preview .overlay h3', visible: :hidden)

      expect(projects[0]['innerHTML']).to have_text('Project 1')
    end

    scenario 'newest best project first on home page after changing date' do
      project_2.date = Time.now
      project_2.save!

      visit categories_path

      projects = page.all('.project-preview .overlay h3', visible: :hidden)

      expect(projects[0]['innerHTML']).to have_text('Project 2')
    end

  end

end
