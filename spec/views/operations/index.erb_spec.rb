require 'rails_helper'

RSpec.describe 'Operations index page', type: :system do
  before :each do
    @user = User.find_or_create_by(email: 'johndoe@example.com') do |u|
      u.name = 'John Doe'
      u.password = Devise.friendly_token
    end
    @category = Category.find_or_create_by(name: 'Food', icon_url: 'https://www.shutterstock.com/image-photo/group-white-paper-ship-one-260nw-1121086322.jpg')
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

    login_as @user
  end

  it 'shows all operations' do
    visit category_operations_path(@category)
    expect(page).to have_content('Pay tomato')
    expect(page).to have_content('Pay pepper')
  end

  it 'shows the total amount of the category and the one of each operation' do
    visit category_operations_path(@category)
    expect(page).to have_content('$100')
    expect(page).to have_content('$200')
    expect(page).to have_content('$300')
  end

  it 'shows the category form when clicking on the Add a new transaction button' do
    visit category_operations_path(@category)
    click_link('Add a new transaction')
    expect(page).to have_content('Add Transaction')
  end
end
