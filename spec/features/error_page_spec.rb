require 'rails_helper'

feature 'ERROR PAGE' do
  scenario '404 page appears if page does not exist' do
    visit '/inexistent-url'

    expect(page).to have_selector('h1', text: 'Страница не найдена')
  end

  scenario '/404' do
    visit '/404'

    expect(page).to have_selector('h1', text: 'Страница не найдена')
  end

  scenario '404 page appears if params invalid' do
    visit project_path(100)

    expect(page).to have_selector('h1', text: 'Страница не найдена')
  end

  scenario 'it contains a link to home page' do
    visit '/404'

    expect(page).to have_selector('a.btn', text: 'Главная')
  end
end
