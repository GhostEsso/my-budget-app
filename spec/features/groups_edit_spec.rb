require 'rails_helper'

RSpec.describe 'When I open Group Edit page', type: :feature do
  before(:each) do
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
    visit(edit_group_path(@group1))
  end
  context 'shows the correct' do
    it 'heading' do
      expect(page).to have_content('edit category')
    end

    it 'labels' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Icon link *')
    end

    it 'placeholders' do
      expect(page).to have_css("input[value='Food']")
      expect(page).to have_css("input[value='https://i.pravatar.cc/300?img=13']")
    end

    it 'Update Category button' do
      expect(page).to have_button('update', type: 'submit')
    end
  end

  context 'When I fill the fields and click on Update button' do
    before(:each) do
      fill_in 'Name', with: 'Meals'
      fill_in 'Icon', with: 'https://i.pravatar.cc/300?img=6'
      click_button('update')
    end

    it "redirects me to that Group's transactions page" do
      expect(page).to have_current_path(group_purchases_path(@group1))
    end

    it 'group_transaction page shows the updated Group' do
      expect(page).to_not have_content('Food')
      expect(page).to have_content('Meals')
    end

    it 'group_transaction page shows the updated icon' do
      expect(page).to_not have_css("img[src='https://i.pravatar.cc/300?img=5']")
      expect(page).to have_css("img[src='https://i.pravatar.cc/300?img=6']")
    end
  end
end
