require 'rails_helper'

feature 'PORTFOLIO', js: true do
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_portfolio_path
  end

  context 'Add portfolio page' do
    before(:each) do
      click_link 'Create'
    end

    scenario 'it fails without title' do
      fill_in 'portfolio_title', with: ''
      fill_in 'portfolio_home_title', with: 'some text'
      fill_in 'portfolio_description', with: 'some text'
      click_button 'Create Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without home title' do
      fill_in 'portfolio_title', with: 'some text'
      fill_in 'portfolio_home_title', with: ''
      fill_in 'portfolio_description', with: 'some text'
      click_button 'Create Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_home_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without description' do
      fill_in 'portfolio_title', with: 'some text'
      fill_in 'portfolio_home_title', with: 'some text'
      fill_in 'portfolio_description', with: ''
      click_button 'Create Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_description.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      fill_in 'portfolio_title', with: 'some text'
      fill_in 'portfolio_home_title', with: 'some text'
      fill_in 'portfolio_description', with: 'some text'
      click_button 'Create Portfolio'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PORTFOLIO PAGE HAS BEEN CREATED')
      expect(page).to have_text('some text')
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: 'PAGE IS NOT CREATED')
    end

    scenario 'is not visible if not created' do
      visit root_path

      expect(page).not_to have_selector('a.nav-link', text: 'PORTFOLIO')
    end

    scenario 'is visible if created' do
      portfolio = FactoryGirl.create(:portfolio)

      visit root_path

      expect(page).to have_selector('a.nav-link', text: 'PORTFOLIO')
      expect(page).to have_selector('h2', text: portfolio.home_title.upcase)

      visit categories_path

      expect(page).to have_selector('h2', text: portfolio.title.upcase)
      expect(page).to have_selector('p', text: portfolio.description)
    end
  end

  context 'Update portfolio page' do
    let!(:portfolio) { FactoryGirl.create(:portfolio) }

    before(:each) do
      visit admin_portfolio_path
      click_link 'Edit'
    end

    scenario 'it fails without title' do
      fill_in 'portfolio_title', with: ''
      fill_in 'portfolio_home_title', with: 'some text'
      fill_in 'portfolio_description', with: 'some text'
      click_button 'Update Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without home title' do
      fill_in 'portfolio_title', with: 'some text'
      fill_in 'portfolio_home_title', with: ''
      fill_in 'portfolio_description', with: 'some text'
      click_button 'Update Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_home_title.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it fails without description' do
      fill_in 'portfolio_title', with: 'some text'
      fill_in 'portfolio_home_title', with: 'some text'
      fill_in 'portfolio_description', with: ''
      click_button 'Update Portfolio'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.portfolio_description.has-error span.help-block', text: "can't be blank")
    end

    scenario 'it succeed with valid data' do
      fill_in 'portfolio_title', with: 'some text 2'
      fill_in 'portfolio_home_title', with: 'some text 2'
      fill_in 'portfolio_description', with: 'some text 2'
      click_button 'Update Portfolio'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PORTFOLIO PAGE HAS BEEN UPDATED')
      expect(page).to have_text('some text 2')
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).to have_selector('h3', text: portfolio.title.upcase)
    end

    scenario 'delete about section' do
      visit admin_portfolio_path

      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'SUCCESSFULLY DELETED')
    end
  end
end
