require 'spec_helper'
require 'rails_helper'

feature "allows comments on goals" do
  scenario "logged out user can't make comments" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    visit goal_url(Goal.first)
    expect(page).to_not have_button('Submit Comment')
  end

  scenario "logged in user can make comments" do
    sign_up_and_make_goal_as_test('Public')
    expect(page).to have_button('Submit Comment')
    fill_in("Comment", with: "words.")
    click_button('Submit Comment')
    expect(page).to have_content('words.')
    expect(page).to have_content('Posted By: test')
  end
end

feature "allows comments on users" do

  scenario "logged out user can't make comments" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    visit user_goals_url(User.first)
    expect(page).to_not have_button('Submit Comment')
  end

  scenario "logged in user can make comments" do
    sign_up_and_make_goal_as_test('Public')
    click_link('Back to Goals')
    expect(page).to have_button('Submit Comment')
    fill_in("Comment", with: "words.")
    click_button('Submit Comment')
    expect(page).to have_content('words.')
    expect(page).to have_content('Posted By: test')
  end
end
