require 'rails_helper'

RSpec.feature "user can create account from home" do
  scenario "I see my dashboard" do

    visit '/'

    expect(page).to have_content("Login")

    click_link "Create Account"

    fill_in "First Name:", with: "Jordan"
    fill_in "Last Name:", with: "Lawler"
    fill_in "Username:", with: "jlawlz"
    fill_in "Password:", with: "password"
    fill_in "Password Confirmation", with: "password"

    within "form#new_user" do
      click_button "Create"
    end

    user = User.find_by(username: 'jlawlz')

    expect(current_path).to eq dashboard_path

    expect(page).to have_content "Jordan"
    expect(page).to_not have_content "Login"
    expect(page).to have_content "Logout"
  end

  scenario "is redirected to account page if username already exists" do
    user = create(:user)

    visit new_user_path

    fill_in "First Name:", with: "Justin"
    fill_in "Last Name:", with: "Lawlerz"
    fill_in "Username:", with: user.username
    fill_in "Password:", with: "password1"
    fill_in "Password Confirmation", with: "password1"

    within "form#new_user" do
      click_button "Create"
    end

    expect(current_path).to eq new_user_path
    expect(page).to have_content "Username #{user.username} is already taken. Please choose a different username"
  end
end
