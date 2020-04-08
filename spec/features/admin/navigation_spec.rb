require 'rails_helper'

RSpec.describe 'As an admin' do
  it 'I see the same links as a regular user plus and minus some' do
    admin = User.create({name: "Regina",
                         street_address: "6667 Evil Ln",
                         city: "Storybrooke",
                         state: "ME",
                         zip_code: "00435",
                         email_address: "evilqueen@example.com",
                         password: "henry2004",
                         password_confirmation: "henry2004",
                         role: 2
                       })

    visit '/'

    click_link 'Log in'

    fill_in :email_address, with: 'evilqueen@example.com'
    fill_in :password, with: 'henry2004'
    click_button 'Log in'

    expect(current_path).to eq('/admin')
    expect(page).to have_content("Logged in as #{admin.name}")

    within 'nav' do
      expect(page).to have_no_link('Log in')
      expect(page).to have_no_link('Register')
      expect(page).to have_no_link('Cart')
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
      click_link "Dashboard"
    end

    expect(current_path).to eq('/admin')

    within 'nav' do
      click_link "Users"
    end

    expect(current_path).to eq('/admin/users')

    within 'nav' do
      click_link "Log out"
    end

    expect(current_path).to eq('/admin/logout')
  end
end



# As an admin
# I see the same links as a regular user
# Plus the following links
# - a link to my admin dashboard ("/admin")
# - a link to see all users ("/admin/users")
#
# Minus the following links/info
# - a link to my shopping cart ("/cart") or count of cart items