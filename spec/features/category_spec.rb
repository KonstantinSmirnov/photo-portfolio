require 'rails_helper'

feature 'CATEGORY', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_portfolio_path
  end

  context 'Add new category' do

    scenario 'it fails without text' do
      click_link 'Add category'

      fill_in 'category_title', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.category_title.has-error span.help-block', text: "поле не заполнено")
    end


    scenario 'it succeed with valid data' do
      click_link 'Add category'

      fill_in 'category_title', with: 'some text'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW CATEGORY HAS BEEN CREATED')
    end

    scenario 'it can be cancelled when creating "new" category' do
      click_link 'Add category'

      click_link 'Cancel'

      expect(page).not_to have_text('CANCEL')
    end
  end

  context 'Update category' do

    before(:each) do
      click_link 'Add category'

      fill_in 'category_title', with: 'some text'

      click_button 'Create'

      within "#categories-list" do
        first(:link, "Edit").click
      end
    end

    scenario 'can start editing category' do
      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editind category' do
      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can update category with valid data' do
      fill_in 'category_title', with: 'new text'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CATEGORY HAS BEEN UPDATED')
      expect(page).to have_selector('h5', text: 'new text')
    end

    scenario 'can delete category' do
      visit admin_portfolio_path

      within "#categories-list" do
        first(:link, "Delete").click
      end
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'CATEGORY HAS BEEN DELETED')
    end
  end

  context 'Maintaining categories' do
    let!(:category) { FactoryGirl.create(:category, portfolio: portfolio) }
    let!(:project) { FactoryGirl.create(:project, portfolio: portfolio)}

    scenario 'does not show categories if a category created, but no projects asigned' do
      visit categories_path

      expect(page).not_to have_selector('.category-link', text: category.title.upcase)
    end

    scenario 'does not show category ALL if a category created, but no projects asigned' do
      visit categories_path

      expect(page).not_to have_selector('.category-link', text: 'ALL')
    end

    scenario 'it shows category name if a project is assigned to a category' do
      project.category = category
      project.save!

      visit categories_path

      expect(page).to have_selector('.category-link', text: category.title.upcase)
    end

    scenario 'it shows common category All if has at least one active category' do
      project.category = category
      project.save!

      visit categories_path

      expect(page).to have_selector('.category-link', text: 'ВСЕ')
    end

    scenario 'it shows projects assigned to a category inside the category' do
      project.category = category
      project.save!

      visit category_path(category)

      expect(page).to have_selector('h5.text-center', text: project.title, visible: false)
    end

    scenario 'a project without category is not displayed in category' do
      project2 = FactoryGirl.create(:project, portfolio: portfolio)

      visit category_path(category)
      
      expect(page).not_to have_selector('h3.text-center', text: project2.title, visible: false)
    end
  end

  context 'Drag and drop' do
    let!(:category_1) { FactoryGirl.create(:category, portfolio: portfolio, title: 'Category 1') }
    let!(:category_2) { FactoryGirl.create(:category, portfolio: portfolio, title: 'Category 2') }
    let!(:project_1) { FactoryGirl.create(:project, portfolio: portfolio, category: category_1)}
    let!(:project_2) { FactoryGirl.create(:project, portfolio: portfolio, category: category_2)}


    scenario 'can change order in admin' do
      visit admin_portfolio_path
      expect(page).to have_selector('#categories-list div.category:nth-child(1) h5', text: 'Category 1')
      expect(page).to have_selector('#categories-list div.category:nth-child(2) h5', text: 'Category 2')

      # using jquery.simulate.drag-sortable.js
      page.execute_script %Q{
        $('#categories-list div.category:first').simulateDragSortable({move: 1});
      }

      expect(page).to have_selector('#categories-list div.category:nth-child(1) h5', text: 'Category 2')
      expect(page).to have_selector('#categories-list div.category:nth-child(2) h5', text: 'Category 1')
    end

    scenario 'can change order of categories on categories page' do
      visit categories_path
      expect(page).to have_selector('.projects-categories a.category-link:nth-child(2)', text: 'CATEGORY 1')
      expect(page).to have_selector('.projects-categories a.category-link:nth-child(3)', text: 'CATEGORY 2')

      visit admin_portfolio_path
      # using jquery.simulate.drag-sortable.js
      page.execute_script %Q{
        $('#categories-list div.category:first').simulateDragSortable({move: 1});
      }
      sleep 1
      visit categories_path
      expect(page).to have_selector('.projects-categories a.category-link:nth-child(2)', text: 'CATEGORY 2')
      expect(page).to have_selector('.projects-categories a.category-link:nth-child(3)', text: 'CATEGORY 1')
    end
  end
end
