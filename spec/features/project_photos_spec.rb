require 'rails_helper'

feature 'PROJECT PHOTO', js: true do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:portfolio) { FactoryGirl.create(:portfolio) }
  let!(:project) { FactoryGirl.create(:project, portfolio: portfolio) }

  before(:each) do
    log_in_with(admin.email, 'password')
    visit admin_project_path(project)
  end

  context 'Add photo' do

    before(:each) do
      click_link 'Add'
    end

    scenario 'it has cancel button' do
      click_link 'Cancel'

      expect(page).not_to have_text('CANCEL')
    end

    scenario 'it fails without alt text' do
      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: ''
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_alt.has-error span.help-block', text: "поле не заполнено")
    end

    scenario 'it fails without image' do
      # Do not attach image
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_image.has-error span.help-block', text: "поле не заполнено")
    end

    scenario 'it succeeds with valid data' do
      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Create'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'NEW PHOTO HAS BEEN CREATED')
    end

    scenario 'added photo is visible on project page' do
      photo = FactoryGirl.create(:photo, alt: 'Photo 1', project: project)

      visit categories_path
      page.should have_xpath("//img[@alt='Photo 1' and @class='img-fluid']")
    end
  end

  context 'Update photo' do
    let!(:photo) { FactoryGirl.create(:photo, project: project) }

    before(:each) do
      visit admin_project_path(project)
    end

    scenario 'can start editing photo' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      expect(page).to have_selector('input.btn[value=Update]')
      expect(page).to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'can cancel editing photo' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      click_link 'Cancel'

      expect(page).not_to have_selector('input.btn[value=Update]')
      expect(page).not_to have_selector('a.btn', text: 'CANCEL')
    end

    scenario 'it fails without alt text' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      fill_in 'photo_alt', with: ''
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-danger', text: 'PLEASE CHECK ERRORS')
      expect(page).to have_selector('.photo_alt.has-error span.help-block', text: "поле не заполнено")
    end

    scenario 'can update photo with valid data' do
      within "#project-photos" do
        first(:link, "Edit").click
      end

      page.attach_file('photo_image', Rails.root + 'public/images/test_image.png')
      fill_in 'photo_alt', with: 'test alt description'
      click_button 'Update'

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PHOTO HAS BEEN UPDATED')
    end

    scenario 'can delete photo' do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_selector('.flash-alert.flash-success', text: 'PHOTO HAS BEEN DELETED')
    end
  end

  context 'Drag and drop' do
    let!(:photo_1) { FactoryGirl.create(:photo, alt: 'Photo 1', project: project) }
    let!(:photo_2) { FactoryGirl.create(:photo, alt: 'Photo 2', project: project) }

    #jquery.simulate.drag-sortable.js DOES NOT WORK FOR HORIZONTAL LIST

    # scenario 'can change order in admin' do
    #   visit admin_project_path(project)
    #   expect(page).to have_selector('#project-photos div.photo:nth-child(1) h5', text: 'Photo 1')
    #   expect(page).to have_selector('#project-photos div.photo:nth-child(2) h5', text: 'Photo 2')
    #
    #   # using jquery.simulate.drag-sortable.js
    #   page.execute_script %Q{
    #     $('#project-photos div.photo:first').simulateDragSortable({move: 1});
    #   }
    #
    #   expect(page).to have_selector('#project-photos div.photo:nth-child(1) h5', text: 'Photo 2')
    #   expect(page).to have_selector('#project-photos div.photo:nth-child(2) h5', text: 'Photo 1')
    # end

    #jquery.simulate.drag-sortable.js DOES NOT WORK FOR HORIZONTAL LIST

    # scenario 'can change cover photo of project' do
    #   visit categories_path
    #   page.should have_xpath("//img[@alt='Photo 1' and @class='img-fluid']")
    #   page.should_not have_xpath("//img[@alt='Photo 2' and @class='img-fluid']")
    #
    #   visit admin_project_path(project)
    #   # using jquery.simulate.drag-sortable.js DOES NOT WORK FOR HORIZONTAL LIST
    #   # page.execute_script %Q{
    #   #   $('#project-photos div.photo:first').simulateDragSortable({move: 1});
    #   #
    #   sleep 1
    #   visit categories_path
    #   page.should have_xpath("//img[@alt='Photo 2' and @class='img-fluid']")
    #   page.should_not have_xpath("//img[@alt='Photo 1' and @class='img-fluid']")
    # end

    #jquery.simulate.drag-sortable.js DOES NOT WORK FOR HORIZONTAL LIST

    # scenario 'can change order of photos on project page' do
    #   visit project_path(project)
    #
    #   page.should have_xpath("//img[@alt='Photo 1' and @class='slick-slide slick-current slick-center']")
    #
    #   visit admin_project_path(project)
    #   # using jquery.simulate.drag-sortable.js
    #   page.execute_script %Q{
    #     $('#project-photos div.photo:first').simulateDragSortable({move: 1});
    #   }
    #   sleep 1
    #   visit project_path(project)
    #   page.should have_xpath("//img[@alt='Photo 2' and @class='slick-slide slick-current slick-center']")
    # end
  end
end
