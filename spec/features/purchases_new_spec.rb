require 'rails_helper'

RSpec.describe 'When I open New Purchase page', type: :feature do
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
    visit(new_group_purchase_path(@group1))
  end

  context 'shows the correct' do
    it 'heading' do
      expect(page).to have_content('new transaction')
    end

    it 'labels' do
      expect(page).to have_content('name')
      expect(page).to have_content('amount, $')
      expect(page).to have_content('categories')
    end

    it 'existing groups' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Cosmetics')
    end

    it 'placeholders' do
      expect(page).to have_css("input[placeholder='Bodyshop cream']")
      expect(page).to have_css("input[placeholder='15']")
    end

    it 'Add Trasaction button' do
      expect(page).to have_button('add transaction', type: 'submit')
    end
  end

  context 'When I fill the fields and click on Add Trasaction button' do
    before(:each) do
      fill_in 'name', with: 'Coffee'
      fill_in 'amount', with: '15'
      check 'Food'
      check 'Cosmetics'
      click_button('add transaction')
    end

    it "redirects me to that Group's Transactions list" do
      expect(page).to have_current_path(group_purchases_path(@group1))
    end

    it 'all checked Groups show the newly added Transaction' do
      expect(page).to have_content('Coffee')
      visit(group_purchases_path(@group2))
      expect(page).to have_content('Coffee')
    end

    it 'recalculates the Total Expences of all checked Groups' do
      expect(page).to have_content('$25.0')
      visit(group_purchases_path(@group2))
      expect(page).to have_content('$15.0')
    end
  end

  context 'When I click on a Add Transaction button without filling the form' do
    it 'renders new page again' do
      click_button('add transaction')
      expect(page).to have_content('new transaction')
      expect(page).to have_button('add transaction', type: 'submit')
    end

    it 'shows error message' do
      click_button('add transaction')
      expect(page).to have_content('You must choose at least one category!')
    end
  end
end
