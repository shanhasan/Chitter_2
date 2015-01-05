require 'spec_helper'

feature "User signs up" do
  
  scenario "when being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, shan119@hotmail.co.uk")
    expect(User.first.email).to eq("shan119@hotmail.co.uk")
  end

  scenario "with a password that doesn't match" do
    expect{ sign_up('a@a.com', 'pass', 'wrong')}.to change(User, :count).by(0)
  end

  def sign_up(email = "shan119@hotmail.co.uk",
              password = "hishan",
              password_confirmation = "hishan")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end
end