require 'spec_helper'

feature "User signs up" do
  
  scenario "when being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, shan119@hotmail.co.uk")
    expect(User.first.email).to eq("shan119@hotmail.co.uk")
  end

  def sign_up(email = "shan119@hotmail.co.uk",
              password = "hishan")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end
end