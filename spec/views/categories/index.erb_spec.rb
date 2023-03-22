require 'rails_helper'

RSpec.describe 'Categories index page', type: :system do
  before :each do
    user = User.find_or_create_by(email: 'johndoe@example.com') do |u|
      u.name = 'John Doe'
      u.password = Devise.friendly_token
    end

    category1 = Category.find_or_create_by(name: 'Food') do |c|
      c.image.attach(io: File.open(Rails.root.join('spec', 'images', 'food.jpeg')), filename: 'food.jpeg')
    end
    category2 = Category.find_or_create_by(name: 'Clothes') do |c|
      c.image.attach(io: File.open(Rails.root.join('spec', 'images', 'clothes.jpeg')), filename: 'clothes.jpeg')
    end

    category1.operations.find_or_create_by(name: 'Pay tomato', amount: 100, author: user)
    category1.operations.find_or_create_by(name: 'Pay pepper', amount: 200, author: user)

    category2.operations.find_or_create_by(name: 'Pay shirt', amount: 300, author: user)
    category2.operations.find_or_create_by(name: 'Pay pants', amount: 400, author: user)

    login_as user
  end

  it 'shows all categories' do
    visit categories_path
    expect(page).to have_content('Food')
    expect(page).to have_content('Clothes')
  end

  it 'shows the total amount of each category' do
    visit categories_path
    expect(page).to have_content('$300')
    expect(page).to have_content('$700')
  end

  it 'shows the operations of a category when clicking on it' do
    visit categories_path
    click_link('Food')
    expect(page).to have_content('Food')
    expect(page).to have_content('Pay tomato')
    expect(page).to have_content('Pay pepper')
  end

  it 'shows the category form when clicking on the Add a new category button' do
    visit categories_path
    click_link('Add a new category')
    expect(page).to have_content('Add Category')
  end
end
