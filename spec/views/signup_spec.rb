require 'rails_helper'

RSpec.describe 'Sign up page', type: :system do
  it 'fills the Sign up form and submits' do
    password = Devise.friendly_token
    visit new_user_registration_path

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'johndoe@example.com'
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    find('input[name="commit"]').click

    expect(page).to have_content('Categories')
  end
end
