require 'rails_helper'
require 'devise'


# def login_user
#    user = FactoryBot.create(:user)
#    login_as(user)
# end


def new_user 
  visit root_path
  click_link 'Sign-in/Sign-up'
  click_link 'Sign up'
  within("form") do
    fill_in "Email", with: "testing@test.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"
  end
end

RSpec.feature "Projects", type: :feature do
  context "Create new project" do     
    before(:each) do
      new_user
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      fill_in "Link", with: "Test link"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end


    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content" , link: "linkylink") }
    before(:each) do
      new_user
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
        fill_in "Link", with: "New Link Content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated.")
    end

    scenario "should fail" do
      within("form") do  
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content", link: "test link") }
    scenario "remove project" do
      new_user
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end