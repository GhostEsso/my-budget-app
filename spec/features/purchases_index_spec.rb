require 'rails_helper'

RSpec.describe 'When I open Purchases index page', type: :feature do
  before(:each) do
    User.delete_all @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
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
end
