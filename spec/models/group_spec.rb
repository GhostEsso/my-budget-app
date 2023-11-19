require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Food', 'icon' => 'missing_avatar.png' } }
  let(:no_name) { { 'user' => @user, 'icon' => 'missing_avatar.png' } }
  let(:no_user) { { 'name' => 'Food', 'icon' => 'missing_avatar.png' } }
  let(:name_too_long) { { 'user' => @user, 'name' => 'A' * 37, 'icon' => 'missing_avatar.png' } }
  let(:no_icon) { { 'user' => @user, 'name' => 'Food' } }
  let(:icon_too_long) do
    { 'user' => @user, 'name' => 'Food', 'icon' => 'A' * 251 }
  end

  before :all do
    @user = User.create(name: 'Tom')
  end

  context 'user' do
    it 'is valid when attribute exists' do
      expect(Group.create(valid_attributes)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Group.create(no_user)).to_not be_valid
    end
  end

  context 'name' do
    it 'is valid when attribute exists' do
      expect(Group.create(valid_attributes)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Group.create(no_name)).to_not be_valid
    end

    it 'is not valid when attribute length is more than 36' do
      expect(Group.create(name_too_long)).to_not be_valid
    end

    it 'is not valid when attribute is not unique' do
      Group.create(name: 'Food', icon: 'missing_avatar.png')
      expect(Group.create(name: 'Food', icon: 'missing_avatar.png')).to_not be_valid
    end
  end

  context 'icon' do
    it 'is valid when attribute exists' do
      expect(Group.create(valid_attributes)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Group.create(no_icon)).to_not be_valid
    end

    it 'is not valid when attribute length is more than 250' do
      expect(Group.create(icon_too_long)).to_not be_valid
    end
  end
end
