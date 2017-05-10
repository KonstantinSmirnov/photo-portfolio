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

    scenario 'webpage does not have a contact phone in the footer' do
      expect(page).not_to have_selector('footer .contacts small', text: 'Phone:')
    end

    scenario 'webpage does not have a contact email in the footer' do
      expect(page).not_to have_selector('footer .contacts small', text: 'Email:')
    end

    scenario 'webpage does not have a facebook link in the footer' do
      expect(page).not_to have_selector('footer .social i.fa-facebook-official')
    end

    context 'contact page' do
      before(:each) do
        visit contact_path
      end
      scenario 'webpage does not have a contact phone on the contact page' do
        expect(page).not_to have_selector('#contact-form p', text: 'Phone:')
      end

      scenario 'webpage does not have a contact email on the contact page' do
        expect(page).not_to have_selector('#contact-form p', text: 'Email:')
      end
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

    scenario 'webpage has a proper contact phone number in the footer' do
      expect(page).to have_selector('footer .contacts small', text: "Phone: #{setting.contact_phone}")
    end

    scenario 'webpage has a proper contact email in the footer' do
      expect(page).to have_selector('footer .contacts small', text: "Email: #{setting.contact_email}")
    end

    scenario 'webpage does not have a facebook link in the footer' do
      expect(page).to have_selector('footer .social i.fa-facebook-official')
    end

    context 'contact page default values' do
      before(:each) do
        visit contact_path
      end
      scenario 'contact page has default keywords if does not have own' do
        expect(page).to have_css("meta[name=\"keywords\"][content=\"#{setting.seo_keywords}\"]", visible: false)
      end

      scenario 'contact webpage has a default seo description if does not have own' do
        expect(page).to have_css("meta[name=\"description\"][content=\"#{setting.seo_description}\"]", visible: false)
      end

      scenario 'contact page has a contact phone' do
        expect(page).not_to have_selector('#contact-form p', text: "Email: #{setting.contact_phone}")
      end

      scenario 'contact page has a contact email' do
        expect(page).to have_selector('#contact-form p', text: "Email: #{setting.contact_email}")
      end
    end
  end
end
