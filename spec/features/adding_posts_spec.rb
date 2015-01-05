require 'spec_helper'

feature "user adds a new post" do
  scenario "when browsing the homepage" do
    expect(Post.count).to eq(0)
    visit '/'
    add_post("Go Makers")
    expect(Post.count).to eq(1)
    post = Post.first
    expect(post.message).to eq("Go Makers")
  end

  def add_post(message)
    within('#new-post') do
      fill_in 'message', :with => message
      click_button "Add post"
    end
  end
end