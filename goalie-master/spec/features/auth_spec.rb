# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content('Sign Up')
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up_as_test
      expect(page).to have_content('test')
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    sign_up_as_test
    click_button('Sign Out')
    visit new_session_url
    fill_in('Username', with: 'test')
    fill_in('Password', with: '123456')
    click_button('Sign In')
    expect(page).to have_content('test')
  end

end

feature "logging out" do

  scenario "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content('Sign Out')
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up_as_test
    click_button('Sign Out')
    expect(page).to_not have_content('test')
  end

end
