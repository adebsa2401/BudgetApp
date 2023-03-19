require 'rails_helper'

RSpec.describe Operation, type: :model do
  let :user do
    User.find_or_create_by(email: 'johndoe@example.com') do |u|
      u.name = 'John Doe'
      u.encrypted_password = Devise.friendly_token
    end
  end

  let :category do
    Category.find_or_create_by(name: 'Food', icon_url: 'https://www.shutterstock.com/image-photo/group-white-paper-ship-one-260nw-1121086322.jpg')
  end

  let :operation do
    category.operations.find_or_create_by(name: 'Pay tomato', amount: 100, author: user)
  end

  it 'should fail if name is not present' do
    operation.name = nil
    expect(operation).to_not be_valid
  end

  it 'should fail if amount is not present' do
    operation.amount = nil
    expect(operation).to_not be_valid
  end

  it 'should fail if name is too short' do
    operation.name = 'Fo'
    expect(operation).to_not be_valid
  end

  it 'belongs to a category' do
    expect(operation.categories.length).to be > 0
  end
end
