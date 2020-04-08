require 'rails_helper'

RSpec.describe 'As a merchant' do
  it 'can see same links as default user in addition to a merchant dashboard link' do
    merchant1 = User.create!({name: "Elmo", street_address: "123 Sesame St", city: "New York",
                             state: "NY", zip_code: "10001", email_address: "elmo@example.com",
                             password: "password1", password_confirmation: "password1",
                             role: 1})

    visit '/'
    click_link 'Log in'

    fill_in :email_address, with: 'elmo@example.com'
    fill_in :password, with: 'password1'
    click_button 'Log in'

    expect(merchant1.role).to eq("merchant")
    expect(current_path).to eq('/user/profile')
    expect(page).to have_content("Logged in as #{merchant1.name}")

    within 'nav' do
      expect(page).to have_no_link('Log in')
      expect(page).to have_no_link('Register')
    end

    within 'nav' do
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')

    within 'nav' do
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')

    within 'nav' do
      click_link "Home"
    end

    expect(current_path).to eq('/')

    within 'nav' do
      click_link "Cart"
    end

    expect(current_path).to eq('/cart')

    within 'nav' do
      click_link "Profile"
    end

    expect(current_path).to eq('/user/profile')

    within 'nav' do
      click_link "Merchant Dashboard"
    end

    expect(current_path).to eq('/merchant')

    within 'nav' do
      click_link "Log out"
    end

    expect(current_path).to eq('/user/logout')
  end
end
