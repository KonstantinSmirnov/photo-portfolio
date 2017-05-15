require 'rails_helper'

feature 'ROBOTS TXT' do
  scenario 'it contains link to sitemap' do
    visit '/robots.txt'

    expect(page).to have_text('http://www.example.com/sitemap.xml')
  end
end
