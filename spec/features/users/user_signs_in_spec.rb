require 'rails_helper'

feature "User signs in" do
  let(:this_user) do
    FactoryGirl.create(:user)
  end

  scenario 'an existing user specifies a valid username and password' do
    visit root_path
    sign_in_as(this_user)
    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'a nonexistent email and password is supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Username', with: 'myusername'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Username or password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end
end
