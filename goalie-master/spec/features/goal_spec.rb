require 'spec_helper'
require 'rails_helper'

feature "displays public goals to everyone" do

  scenario "can see own public goals" do
    sign_up_and_make_goal_as_test('Public')
    click_link('Back to Goals')
    expect(page).to have_content('Make Friends')
  end

  scenario "can see other's public goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    sign_up_user("other_guy", "dope_password")
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    expect(page).to have_content('Make Friends')
  end

  scenario "can see other's public goals while logged out" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    expect(page).to have_content('Make Friends')
  end

end

feature "displays private goals only to owner" do

  scenario "can see own private goals" do
    sign_up_and_make_goal_as_test('Private')
    click_link('Back to Goals')
    expect(page).to have_content('Make Friends')
  end

  scenario "cannot see other's private goals" do
    sign_up_and_make_goal_as_test('Private')
    click_button('Sign Out')
    sign_up_user("other_guy", "dope_password")
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    expect(page).to_not have_content('Make Friends')
  end

  scenario "cannot see other's private goals while logged out" do
    sign_up_and_make_goal_as_test('Private')
    click_button('Sign Out')
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    expect(page).to_not have_content('Make Friends')
  end

end

feature "User can destroy goals" do

  scenario "can destroy own goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Delete Goal')
    expect(page).to_not have_content('Make Friends')
  end

  scenario "cannot destroy other's goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    sign_up_user("other_guy", "dope_password")
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    click_link('Make Friends')
    expect(page).to_not have_button('Delete Goal')
  end
end

feature "User can edit goals" do
  scenario "can edit own goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Edit Goal')
    fill_in('Description', with: 'whatever.')
    click_button('Save Goal')
    expect(page).to have_content('whatever.')
  end

  scenario "cannot edit other's goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    sign_up_user("other_guy", "dope_password")
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    click_link('Make Friends')
    expect(page).to_not have_button('Edit Goal')
  end
end

feature "User can complete goals" do

  scenario "goals aren't completed on creation" do
    sign_up_and_make_goal_as_test('Public')
    expect(page).to have_content('Not Completed')
  end

  scenario "can complete uncompleted goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Complete Goal')
    expect(page).to_not have_content('Not Completed')
    expect(page).to have_content('Completed')
  end

  scenario "can uncomplete completed goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Complete Goal')
    click_button('Uncomplete Goal')
    expect(page).to have_content('Not Completed')
  end

  scenario "cannot complete another user's goals" do
    sign_up_and_make_goal_as_test('Public')
    click_button('Sign Out')
    sign_up_user("other_guy", "dope_password")
    test = User.find_by(username: "test")
    visit user_goals_url(test)
    expect(page).to_not have_button('Complete Goal')
  end

end
