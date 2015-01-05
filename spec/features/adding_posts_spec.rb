require 'spec_helper'

feature "user adds a new post" do
  scenario "when browsing the homepage" do
    expect{add_post("Go Makers")}.to change(Post, :count).by(1)
    post = Post.first
    expect(post.message).to eq("Go Makers")
  end

  def add_post(message)
    visit '/'
    within('#new-post') do
      fill_in 'message', :with => message
      click_button "Add post"
    end
  end
end