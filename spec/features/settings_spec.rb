require 'rails_helper'

feature 'SETTINGS' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }
  let!(:contact) { FactoryGirl.create(:contact) }

  context 'not created' do
    before(:each) do
      visit root_path
    end
    scenario 'webpage has a default title in navbar and footer' do
      expect(page).to have_selector('a.navbar-brand', text: 'PHOTO WEBPAGE')
      expect(page).to have_selector('h2.footer-brand a', text: 'PHOTO WEBPAGE')
    end

    scenario 'webpage does not have seo description' do
      expect(page).to have_css('meta[name="description"]', visible: false, text: '')
    end

    scenario 'webpage does not have seo keywords' do
      expect(page).to have_css('meta[name="keywords"]', visible: false, text: '')
    end

    scenario 'webpage does not have seo text on the home page' do
      expect(page).not_to have_selector('#seo-text')
    end
  end

  context 'created' do
    let!(:setting) { FactoryGirl.create(:setting) }

    before(:each) do
      visit root_path
    end
    scenario 'webpage has a proper title in navbar and footer' do
      expect(page).to have_selector('a.navbar-brand', text: setting.webpage_title)
      expect(page).to have_selector('h2.footer-brand a', text: setting.webpage_title)
    end

    scenario 'webpage has a proper seo description on the home page' do
      expect(page).to have_css("meta[name=\"description\"][content=\"#{setting.seo_description}\"]", visible: false)
    end

    scenario 'webpage has a propoer seo keywords on the home page' do
      expect(page).to have_css("meta[name=\"keywords\"][content=\"#{setting.seo_keywords}\"]", visible: false)
    end

    scenario 'webpage has a proper seo text on the home page' do
      expect(page).to have_selector('#seo-text p', text: setting.seo_text)
    end

    context 'contact page default values' do
      let!(:contact) { FactoryGirl.create(:contact) }

      before(:each) do
        visit contact_path
      end
      scenario 'contact page has default keywords if does not have own' do
        expect(page).to have_css("meta[name=\"keywords\"][content=\"#{setting.seo_keywords}\"]", visible: false)
      end

      scenario 'contact webpage has a default seo description if does not have own' do
        expect(page).to have_css("meta[name=\"description\"][content=\"#{setting.seo_description}\"]", visible: false)
      end
    end
  end
end
