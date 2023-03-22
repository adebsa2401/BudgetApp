require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @user = User.find_or_create_by(email: 'johndoe@example.com') do |u|
      u.name = 'John Doe'
      u.password = Devise.friendly_token
    end
    @category = Category.find_or_create_by(name: 'Food') do |c|
      c.image.attach(io: File.open(Rails.root.join('spec', 'images', 'food.jpeg')), filename: 'food.jpeg')
    end
    @operation1 = Operation.find_or_create_by(name: 'Pay tomato') do |o|
      o.amount = 100
      o.author = @user
    end
    @operation2 = Operation.find_or_create_by(name: 'Pay pepper') do |o|
      o.amount = 200
      o.author = @user
    end
    @category.operations << @operation1
    @category.operations << @operation2
    @category.save
  end

  it 'should fail if name is not present' do
    @category.name = nil
    expect(@category).to_not be_valid
  end

  it 'should have image attached' do
    expect(@category.image).to be_attached
  end

  it 'should fail if name is too short' do
    @category.name = 'Fo'
    expect(@category).to_not be_valid
  end

  it 'should fail if total_amount is not equal to the sum of operations' do
    login_as @user
    @category.current_user = @user
    expect(@category.total_amount).to eq(@operation1.amount + @operation2.amount)
  end
end
