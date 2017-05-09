require 'rails_helper'

feature 'PROJECT PAGE', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }
  let!(:project) { FactoryGirl.create(:project, portfolio: portfolio) }

  before(:each) do
    log_in_with(admin.email, 'password')
  end

  scenario 'has a nav link HOME if entered to a project from home page' do
    visit root_path

    find('div.project-preview').click

    expect(page).to have_selector('a.nav-link', text: '< HOME')
  end

  scenario 'nav link HOME leads to home page' do
    visit root_path

    find('div.project-preview').click
    find('a.nav-link', text: '< HOME').click

    expect(current_path).to eq(root_path)
  end

  scenario 'has a nav link PORTFOLIO if entered to a project from portfolio page' do
    visit categories_path

    find('div.project-preview').click

    expect(page).to have_selector('a.nav-link', text: '< PORTFOLIO')
  end

  scenario 'nav link PORTFOLIO leads to home page' do
    visit categories_path

    find('div.project-preview').click
    find('a.nav-link', text: '< PORTFOLIO').click

    expect(current_path).to eq(categories_path)
  end
end
