require 'rails_helper'

RSpec.describe Category, type: :model do
  let :user do
    User.find_or_create_by(email: 'johndoe@example.com') do |u|
      u.name = 'John Doe'
      u.encrypted_password = Devise.friendly_token
    end
  end

  let :category do
    Category.find_or_create_by(name: 'Food', icon_url: 'https://www.shutterstock.com/image-photo/group-white-paper-ship-one-260nw-1121086322.jpg')
  end

  let :operation1 do
    category.operations.find_or_create_by(name: 'Pay tomato', amount: 100, author: user)
  end

  let :operation2 do
    category.operations.find_or_create_by(name: 'Pay pepper', amount: 200, author: user)
  end

  it 'should fail if name is not present' do
    category.name = nil
    expect(category).to_not be_valid
  end

  it 'should fail if icon_url is not present' do
    category.icon_url = nil
    expect(category).to_not be_valid
  end

  it 'should fail if name is too short' do
    category.name = 'Fo'
    expect(category).to_not be_valid
  end

  it 'should fail if total_amount is not equal to the sum of operations' do
    login_as user
    expect(category.total_amount).to eq(operation1.amount + operation2.amount)
  end
end
