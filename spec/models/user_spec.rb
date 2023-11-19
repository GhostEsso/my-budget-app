require 'rails_helper'

RSpec.describe User, type: :model do
  context '#create' do
    it 'is valid with existing name' do
      expect(User.create(name: 'Tom')).to be_valid
    end

    it 'is not valid with blank name' do
      expect(User.create(name: nil)).to_not be_valid
    end

    it 'is not valid with name of more than 36 chars' do
      expect(User.create(name: 'A' * 37)).to_not be_valid
    end
  end
end
