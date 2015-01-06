require 'spec_helper'

feature "User forgets password" do
  
  scenario "when on sign in page" do
    visit '/'
    expect(page).to have_content("Forgot password?")
  end

  scenario "when on forgot password page" do
    visit '/users/forgot_password'
    expect(page).to have_content("Please enter your registered email address")
  end

end