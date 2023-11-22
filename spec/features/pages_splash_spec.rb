require 'rails_helper'

RSpec.describe 'When I open webpage for the first time', type: :feature do
  before(:each) do
    visit unauthenticated_root_path
  end

  context 'shows the correct' do
    it 'heading' do
      expect(page).to have_content('SmartPocket')
    end

    it 'links' do
      expect(page).to have_link('log in', href: new_user_session_path)
      expect(page).to have_link('sign up', href: new_user_registration_path)
    end
  end

  context 'When I click on links' do
    it 'redirects me to sign in pages' do
      click_on('log in')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'redirects me to sign up page' do
      click_on('sign up')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  context 'When I sign up with valid attributes' do
    before(:each) do
      click_on('sign up')
      fill_in 'Name', with: 'Tom'
      fill_in 'Email', with: 'tom@example.com'
      fill_in 'user_password', with: 'topsecret'
      fill_in 'user_password_confirmation', with: 'topsecret'
      click_button 'Sign up'
    end

    it 'redirects me to splash pages' do
      expect(page).to have_current_path(unauthenticated_root_path)
    end

    it 'shows the notice that confirmation email was sent' do
      expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
    end
  end

  context 'When I sign in with valid attributes' do
    before(:each) do
      @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
      @user.confirm
      visit new_user_session_path

      fill_in 'Email', with: 'tom@example.com'
      fill_in 'Password', with: 'topsecret'
      click_button 'Log in'
    end

    it 'redirects me to Groups page' do
      expect(page).to have_current_path(authenticated_root_path)
    end

    it 'redirects me to sign up page' do
      expect(page).to have_content('categories')
    end
  end
end
