require 'spec_helper'

feature "user browses the list of posts" do 
  
  before(:each) {
    Post.create(:message => "Hello World")
  }

  scenario "when opening the homepage" do
    visit '/'
    expect(page).to have_content("Hello World")
  end

end