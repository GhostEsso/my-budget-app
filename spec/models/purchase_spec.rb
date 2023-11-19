require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:valid_attributes) { { 'author' => @user, 'name' => 'Apples', 'amount' => 2 } }
  let(:no_name) { { 'author' => @user, 'amount' => 2 } }
  let(:no_author) { { 'name' => 'Apples', 'amount' => 2 } }
  let(:name_too_long) { { 'author' => @user, 'name' => 'A' * 37, 'amount' => 2 } }
  let(:no_amount) { { 'author' => @user, 'name' => 'Apples' } }
  let(:amount_string) do
    { 'author' => @user, 'name' => 'Apples', 'amount' => 'two' }
  end
  let(:amount_float) do
    { 'author' => @user, 'name' => 'Apples', 'amount' => 0.2 }
  end
  let(:amount_negative) do
    { 'author' => @user, 'name' => 'Apples', 'amount' => -2 }
  end
  let(:amount_integer) do
    { 'author' => @user, 'name' => 'Apples', 'amount' => 2 }
  end

  before :all do
    @user = User.create(name: 'Tom')
  end

  context 'user' do
    it 'is valid when attribute exists' do
      expect(Purchase.create(valid_attributes)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Purchase.create(no_author)).to_not be_valid
    end
  end

  context 'name' do
    it 'is valid when attribute exists' do
      expect(Purchase.create(valid_attributes)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Purchase.create(no_name)).to_not be_valid
    end

    it 'is not valid when attribute length is more than 36' do
      expect(Purchase.create(name_too_long)).to_not be_valid
    end
  end

  context 'amount' do
    it 'is valid when attribute is integer' do
      expect(Purchase.create(amount_integer)).to be_valid
    end

    it 'is not valid when attribute is blank' do
      expect(Purchase.create(no_amount)).to_not be_valid
    end

    it 'is valid when attribute is float' do
      expect(Purchase.create(amount_float)).to be_valid
    end

    it 'is not valid when attribute is negative' do
      expect(Purchase.create(amount_negative)).to_not be_valid
    end

    it 'is not valid when attribute is string' do
      expect(Purchase.create(amount_string)).to_not be_valid
    end
  end
end
