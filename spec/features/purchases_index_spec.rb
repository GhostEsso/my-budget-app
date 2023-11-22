require 'rails_helper'

RSpec.describe 'When I open Purchases index page', type: :feature do
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
    @purchase1 = Purchase.create(name: 'Apples', amount: 6, author: @user, groups: [@group1])
    @purchase2 = Purchase.create(name: 'Bananas', amount: 4, author: @user, groups: [@group1])
    visit(group_purchases_path(@group1))
  end

  it 'shows the correct heading' do
    expect(page).to have_content('transactions')
  end

  it 'shows the name of each purchase' do
    expect(page).to have_content('Apples')
    expect(page).to have_content('Bananas')
  end

  it 'shows the created_at attribute of each purchase (+ for the group name)' do
    expect(page).to have_content(Date.today.strftime('%d %b %Y'), count: 3)
  end

  it 'shows the amount of each purchase' do
    expect(page).to have_content('$6.0')
    expect(page).to have_content('$4.0')
  end

  it 'shows the total amount for the Group' do
    expect(page).to have_content('$10.0')
  end

  it 'shows the Add Transaction button' do
    expect(page).to have_link('add transaction', href: new_group_purchase_path(@group1))
  end

  context 'When I click on a Group name' do
    it "redirects me to that Group's transactions page" do
      click_link('Apples')
      expect(page).to have_current_path(group_purchase_path(@group1, @purchase1))
    end

    it "redirects me to that Group's transactions page" do
      click_link('Bananas')
      expect(page).to have_current_path(group_purchase_path(@group1, @purchase2))
    end
  end

  context 'When I click on a Add Transaction button' do
    it 'redirects me to form that adds new Transaction' do
      click_link('add transaction')
      expect(page).to have_current_path(new_group_purchase_path(@group1))
    end
  end
end
