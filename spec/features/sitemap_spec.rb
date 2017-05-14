require 'rails_helper'

feature 'SITEMAP' do

  context 'visit /sitemap/xml' do
    scenario 'I can see  alink on portfolio page' do
      portfolio = FactoryGirl.create(:portfolio)

      visit '/sitemap.xml'

      expect(page).to have_text('/categories')
    end

    scenario 'I can see link on published project' do
      portfolio = FactoryGirl.create(:portfolio)
      project = FactoryGirl.create(:project, portfolio: portfolio)

      visit '/sitemap.xml'

      expect(page).to have_text("projects/#{project.id}")
    end

    scenario 'I can not see a link on Contact page if not created' do
      visit '/sitemap.xml'

      expect(page).not_to have_text('/contact')
    end

    scenario 'I can see a link on created Contact page' do
      contact_page = FactoryGirl.create(:contact)

      visit '/sitemap.xml'

      expect(page).to have_text('/contact')
    end
  end
end
