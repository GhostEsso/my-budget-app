require 'rails_helper'

RSpec.describe 'When I open Groups index page', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    @user.confirm

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'topsecret'
    click_button 'Log in'

    @group1 = Group.create(user: @user, name: 'Food', icon: 'https://i.pravatar.cc/300?img=13')
    @group2 = Group.create(user: @user, name: 'Cosmetics', icon: 'https://i.pravatar.cc/300?img=1')
    @purchase1 = Purchase.create(name: 'Apples', amount: 5, author: @user, groups: [@group1])
    @purchase2 = Purchase.create(name: 'Bananas', amount: 5, author: @user, groups: [@group1])
    visit(groups_path)
  end

  it 'shows the correct heading' do
    expect(page).to have_content('categories')
  end

  it 'shows the names of each group' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Cosmetics')
  end

  it 'shows the icons of each group' do
    expect(page).to have_css("img[src='#{@group1.icon}']")
    expect(page).to have_css("img[src='#{@group2.icon}']")
  end

  it 'shows the created_at attribute of each group' do
    expect(page).to have_content(Date.today.strftime('%d %b %Y'), count: 2)
  end

  it 'shows the total amount of each group' do
    expect(page).to have_content('$0.0')
    expect(page).to have_content('$10.0')
  end

  it 'shows the Add Category button' do
    expect(page).to have_link('add category', href: new_group_path)
  end

  context 'When I click on a Group name' do
    it "redirects me to that Group's transactions page" do
      click_link('Food')
      expect(page).to have_current_path(group_purchases_path(@group1))
    end

    it "redirects me to that Group's transactions page" do
      click_link('Cosmetics')
      expect(page).to have_current_path(group_purchases_path(@group2))
    end
  end

  context 'When I click on a Add Group button' do
    it 'redirects me to form that adds new Group' do
      click_link('add category')
      expect(page).to have_current_path(new_group_path)
    end
  end
end
